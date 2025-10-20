<?php
require __DIR__ . '/dp.php';
header('Content-Type: application/json');

$k = isset($_GET['k']) ? max(1, intval($_GET['k'])) : 1;
$mode = isset($_GET['mode']) ? $_GET['mode'] : 'avg';

$orderBy = 'ws.avg_7days DESC, ws.ratings_7days DESC, s.name ASC';

if ($mode === 'count') {
    $orderBy = 'ws.ratings_7days DESC, s.name ASC';
} elseif ($mode === 'avg') {
    $orderBy = 'ws.avg_7days DESC, ws.ratings_7days DESC, s.name ASC';
}

$sql = "
WITH week_stats AS (
    SELECT songID,
           AVG(rating) AS avg_7days,
           COUNT(*) AS ratings_7days
    FROM review 
    WHERE timestamp >= NOW() - INTERVAL 7 DAY
    GROUP BY songID
),
lifetime_stats AS (
    SELECT songID,
           ROUND(AVG(rating), 1) AS avg_alltime,
           COUNT(*) AS ratings_alltime
    FROM review
    GROUP BY songID
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
ORDER BY $orderBy
LIMIT 10";

$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $k);
$stmt->execute();
echo json_encode($stmt->get_result()->fetch_all(MYSQLI_ASSOC));