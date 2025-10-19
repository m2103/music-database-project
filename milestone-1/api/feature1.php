<?php
require __DIR__ . '/dp.php';
$k = isset($_GET['k']) ? max(1, intval($_GET['k'])) : 2;

$sql = "
WITH week_stats AS (
    SELECT ratedObjectID AS songID,
           AVG(r.rating) AS avg_7days,
           COUNT(*) AS ratings_7days
    FROM rating r
    WHERE r.ratingType = 'song'
      AND r.rating IS NOT NULL
      AND r.timestamp >= NOW() - INTERVAL 7 DAY
    GROUP BY ratedObjectID
),
lifetime_stats AS (
    SELECT ratedObjectID AS songID,
           ROUND(AVG(rating), 1) AS avg_alltime,
           COUNT(*) AS ratings_alltime
    FROM rating
    WHERE ratingType = 'song'
      AND rating IS NOT NULL
    GROUP BY ratedObjectID
)
SELECT s.songID,
       s.name AS title,
       a.name AS artist_name,
       lt.avg_alltime as avg_rating,
       lt.ratings_alltime as ratings_count
FROM week_stats ws
JOIN lifetime_stats lt ON ws.songID = lt.songID
JOIN song s ON s.songID = ws.songID
JOIN artist a ON a.artistID = s.artistID
WHERE ws.ratings_7days >= ?
ORDER BY ws.avg_7days DESC, ws.ratings_7days DESC, s.name ASC
LIMIT 10";

$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $k);
$stmt->execute();
echo json_encode($stmt->get_result()->fetch_all(MYSQLI_ASSOC));