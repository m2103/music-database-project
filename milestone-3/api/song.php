<?php
require __DIR__ . '/db.php';
header("Content-Type: application/json");

$songID = isset($_GET["songID"]) ? intval($_GET["songID"]) : 0;

if ($songID <= 0) {
    echo json_encode(["error" => "Invalid songID"]);
    exit;
}

$songSql = "
    SELECT
        s.songID,
        s.songName,
        s.artists,
        s.releaseDate,
        s.spotifyURL,
        s.albumName,
        s.albumCover,
        s.avgRating,
        s.reviewCount
    FROM song_summary s
    WHERE s.songID = ?
";

$songStmt = $conn->prepare($songSql);
$songStmt->bind_param("i", $songID);
$songStmt->execute();
$songResult = $songStmt->get_result();
$song = $songResult->fetch_assoc();

if (!$song) {
    echo json_encode(["error" => "Song not found"]);
    exit;
}

$reviewsSql = "
    SELECT 
        u.username AS userName,
        u.name,
        r.rating,
        r.comment,
        r.timestamp,
        u.profilePicture
    FROM review r
    JOIN user u ON u.userID = r.userID
    WHERE r.songID = ?
    ORDER BY r.timestamp DESC
    LIMIT 20
";

$reviewsStmt = $conn->prepare($reviewsSql);
$reviewsStmt->bind_param("i", $songID);
$reviewsStmt->execute();
$reviewsResult = $reviewsStmt->get_result();
$reviews = $reviewsResult->fetch_all(MYSQLI_ASSOC);

echo json_encode([
    "song" => $song,
    "reviews" => $reviews
]);