<?php
// search for songs by title, artist, or album using full text search
header('Content-Type: application/json');
require __DIR__ . '/db.php';

$searchTerm = isset($_GET['q']) ? trim($_GET['q']) : '';

if ($searchTerm === '') {
    echo json_encode([]);
    exit;
}

$tokens = preg_split('/\s+/', $searchTerm);
$tokens = array_filter($tokens, fn($t) => $t !== '');

if (empty($tokens)) {
    echo json_encode([]);
    exit;
}

$booleanQueryParts = [];
foreach ($tokens as $t) {
    $booleanQueryParts[] = '+' . $t . '*';
}
$booleanQuery = implode(' ', $booleanQueryParts);

$sql = "
    SELECT
        ss.songID,
        ss.songName,
        ss.artists,
        ss.albumName,
        ss.albumCover,
        ss.avgRating,
        ss.reviewCount,
        ft.relevance
    FROM song_summary ss
    JOIN (
        SELECT
            s.songID,
            MATCH(s.name) AGAINST (? IN BOOLEAN MODE) AS relevance
        FROM song s
        WHERE MATCH(s.name) AGAINST (? IN BOOLEAN MODE)
    ) ft ON ft.songID = ss.songID
    ORDER BY ft.relevance DESC
    LIMIT 50
";

$stmt = $conn->prepare($sql);
$stmt->bind_param("ss", $booleanQuery, $booleanQuery);
$stmt->execute();
echo json_encode($stmt->get_result()->fetch_all(MYSQLI_ASSOC));
