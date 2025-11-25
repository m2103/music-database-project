<?php
require __DIR__ . '/db.php';
header('Content-Type: application/json');

if (!isset($_GET['userID'])) {
    echo json_encode(['error' => 'userID is required']);
    exit;
}

$userID = intval($_GET['userID']);

$sql = "
SELECT 
    u.username AS userName,
    u.name,
    u.email,
    u.profilePicture,
    DATE_FORMAT(u.dateJoined, '%Y-%m-%d') AS dateJoined,

    (
        SELECT JSON_ARRAYAGG(review_obj)
        FROM (
            SELECT JSON_OBJECT(
                'reviewID', r.reviewID,
                'rating', r.rating,
                'comment', r.comment,
                'timestamp', DATE_FORMAT(r.timestamp, '%Y-%m-%d'),

                'songID', s.songID,
                'songName', s.name,

                'albumID', a.albumID,
                'albumName', a.name,
                'albumCover', a.albumCover,
                'profilePicture', u.profilePicture,

                'artists', (
                    SELECT GROUP_CONCAT(ar.name ORDER BY ar.name SEPARATOR ', ')
                    FROM song_artist sa
                    JOIN artist ar ON ar.artistID = sa.artistID
                    WHERE sa.songID = s.songID
                )
            ) AS review_obj
            FROM review r
            JOIN song s  ON s.songID = r.songID
            JOIN album a ON a.albumID = s.albumID
            WHERE r.userID = u.userID
            ORDER BY r.timestamp DESC
            LIMIT 5
        ) AS recent_reviews
    ) AS recentReviews,

    (
        SELECT JSON_ARRAYAGG(unpopular_obj)
        FROM (
            SELECT JSON_OBJECT(
                'reviewID', ranked.reviewID,
                'rating', ranked.rating,
                'comment', ranked.comment,
                'timestamp', DATE_FORMAT(ranked.timestamp, '%Y-%m-%d'),
                'songID', ranked.songID,
                'songName', ranked.songName,
                'albumID', ranked.albumID,
                'albumName', ranked.albumName,
                'albumCover', ranked.albumCover,
                'artists', ranked.artists,
                'profilePicture', u.profilePicture,
                'avgRating', ranked.avgRating,
                'deviation', ranked.deviation,
                'direction', ranked.direction
            ) AS unpopular_obj
            FROM (
                SELECT 
                    r.reviewID,
                    r.rating,
                    r.comment,
                    r.timestamp,
                    r.songID,
                    s.name AS songName,
                    a.albumID,
                    a.name AS albumName,
                    a.albumCover,
                    (
                        SELECT GROUP_CONCAT(ar.name ORDER BY ar.name SEPARATOR ', ')
                        FROM song_artist sa
                        JOIN artist ar ON ar.artistID = sa.artistID
                        WHERE sa.songID = s.songID
                    ) AS artists,
                    IFNULL(srs.avgRating, r.rating) AS avgRating,
                    ROUND(ABS(r.rating - IFNULL(srs.avgRating, r.rating)), 2) AS deviation,
                    CASE 
                        WHEN r.rating > IFNULL(srs.avgRating, r.rating) THEN 'above'
                        WHEN r.rating < IFNULL(srs.avgRating, r.rating) THEN 'below'
                        ELSE 'equal'
                    END AS direction,
                    ROW_NUMBER() OVER (
                        ORDER BY ABS(r.rating - IFNULL(srs.avgRating, r.rating)) DESC, r.timestamp DESC
                    ) AS rn
                FROM review r
                JOIN song s ON s.songID = r.songID
                JOIN album a ON a.albumID = s.albumID
                LEFT JOIN song_review_summary srs ON srs.songID = r.songID
                WHERE r.userID = u.userID
            ) AS ranked
            WHERE ranked.deviation >= 1.5 AND ranked.rn <= 5
            ORDER BY ranked.deviation DESC, ranked.timestamp DESC
        ) AS unpopular_reviews
    ) AS unpopularReviews

FROM user u
WHERE u.userID = ?
";

$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $userID);
$stmt->execute();

$result = $stmt->get_result()->fetch_assoc();

// Decode aggregated JSON strings into arrays
if ($result) {
    if (isset($result['recentReviews'])) {
        $result['recentReviews'] = json_decode($result['recentReviews'], true);
    }
    if (isset($result['unpopularReviews'])) {
        $result['unpopularReviews'] = json_decode($result['unpopularReviews'], true);
    }
}

echo json_encode($result);