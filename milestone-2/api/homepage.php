<?php
require __DIR__ . '/dp.php';
header('Content-Type: application/json');

$k = isset($_GET['k']) ? max(1, intval($_GET['k'])) : 1;
$mode = isset($_GET['mode']) ? $_GET['mode'] : 'avg';

$orderBy = 'ws.avg_7days DESC, ws.ratings_7days DESC, s.songName ASC';

if ($mode === 'count') {
    $orderBy = 'ws.ratings_7days DESC, s.songName ASC';
} elseif ($mode === 'avg') {
    $orderBy = 'ws.avg_7days DESC, ws.ratings_7days DESC, s.songName ASC';
}

$sql = "
WITH week_stats AS (
  SELECT
    r.songID,
    AVG(r.rating)  AS avg_7days,
    COUNT(*)       AS ratings_7days
  FROM review r
  WHERE r.timestamp >= NOW() - INTERVAL 7 DAY
  GROUP BY r.songID
)
SELECT
  s.songID,
  s.songName,
  s.artists,
  s.avgRating,
  s.reviewCount
FROM song_summary s
JOIN week_stats ws ON ws.songID = s.songID
WHERE ws.ratings_7days >= ?
ORDER BY $orderBy
LIMIT 10";

$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $k);
$stmt->execute();
echo json_encode($stmt->get_result()->fetch_all(MYSQLI_ASSOC));