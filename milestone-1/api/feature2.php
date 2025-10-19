<?php
require __DIR__ . '/dp.php';

$sql = "
WITH week_stats AS (
    SELECT ratedObjectID AS songID,
           COUNT(*) AS ratings_7days
    FROM rating
    WHERE ratingType = 'song'
      AND rating IS NOT NULL
      AND timestamp >= NOW() - INTERVAL 7 DAY
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
ORDER BY ws.ratings_7days DESC, s.name ASC
LIMIT 10";

echo json_encode($conn->query($sql)->fetch_all(MYSQLI_ASSOC));