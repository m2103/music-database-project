<?php
require __DIR__ . '/db.php';
header('Content-Type: application/json');

$userID = isset($_GET['userID']) ? intval($_GET['userID']) : 0;
$minRating = isset($_GET['minRating']) ? floatval($_GET['minRating']) : 4.0;
$limit = isset($_GET['limit']) ? intval($_GET['limit']) : 8;

if ($userID <= 0) {
    echo json_encode(['error' => 'userID is required']);
    exit;
}

$minRating = max(1.0, min($minRating, 5.0));
$limit = max(3, min($limit, 20));

$sql = "
WITH user_high_ratings AS (
    SELECT r.songID, r.rating
    FROM review r
    WHERE r.userID = ? AND r.rating >= ?
),
fav_artists AS (
    SELECT
        sa.artistID,
        AVG(uhr.rating) AS artist_score,
        COUNT(*) AS review_count,
        ROW_NUMBER() OVER (ORDER BY AVG(uhr.rating) DESC, COUNT(*) DESC, sa.artistID) AS artist_rank
    FROM user_high_ratings uhr
    JOIN song_artist sa ON sa.songID = uhr.songID
    GROUP BY sa.artistID
),
fav_albums AS (
    SELECT
        s.albumID,
        AVG(uhr.rating) AS album_score,
        COUNT(*) AS review_count,
        ROW_NUMBER() OVER (ORDER BY AVG(uhr.rating) DESC, COUNT(*) DESC, s.albumID) AS album_rank
    FROM user_high_ratings uhr
    JOIN song s ON s.songID = uhr.songID
    GROUP BY s.albumID
),
top_artists AS (
    SELECT * FROM fav_artists WHERE artist_rank <= 5
),
top_albums AS (
    SELECT * FROM fav_albums WHERE album_rank <= 5
),
candidate_songs AS (
    SELECT
        s.songID,
        MAX(top_artists.artist_score) AS artist_score,
        MAX(top_artists.review_count) AS artist_weight,
        MAX(top_albums.album_score) AS album_score,
        MAX(top_albums.review_count) AS album_weight
    FROM song s
    LEFT JOIN song_artist sa ON sa.songID = s.songID
    LEFT JOIN top_artists ON top_artists.artistID = sa.artistID
    LEFT JOIN top_albums ON top_albums.albumID = s.albumID
    WHERE (top_artists.artistID IS NOT NULL OR top_albums.albumID IS NOT NULL)
      AND NOT EXISTS (
          SELECT 1 FROM review r WHERE r.userID = ? AND r.songID = s.songID
      )
    GROUP BY s.songID
)
SELECT
    ss.songID,
    ss.songName,
    ss.artists,
    ss.albumName,
    ss.albumCover,
    ss.avgRating,
    ss.reviewCount,
    ROUND(
        IFNULL(artist_score, 0) * 0.45 +
        IFNULL(album_score, 0) * 0.35 +
        IFNULL(ss.avgRating, 0) * 0.15 +
        LOG10(GREATEST(ss.reviewCount, 1) + 1) * 0.5,
        3
    ) AS recommendationScore
FROM candidate_songs cs
JOIN song_summary ss ON ss.songID = cs.songID
ORDER BY recommendationScore DESC, ss.reviewCount DESC, ss.songName ASC
LIMIT ?
";

$stmt = $conn->prepare($sql);
$stmt->bind_param("idii", $userID, $minRating, $userID, $limit);
$stmt->execute();

$result = $stmt->get_result();
echo json_encode($result->fetch_all(MYSQLI_ASSOC));

