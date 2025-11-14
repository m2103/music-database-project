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
    ) AS recentReviews

FROM user u
WHERE u.userID = ?
";

$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $userID);
$stmt->execute();

$result = $stmt->get_result()->fetch_assoc();

if (!$result) {
    echo json_encode(['error' => 'User not found']);
    exit;
}

echo json_encode($result);