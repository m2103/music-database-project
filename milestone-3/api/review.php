<?php
require __DIR__ . '/db.php';
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS, GET');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    echo json_encode(['status' => 'ok']);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $songID = isset($_GET['songID']) ? (int) $_GET['songID'] : 0;
    $userID = isset($_GET['userID']) ? (int) $_GET['userID'] : 0;

    if ($songID <= 0 || $userID <= 0) {
        http_response_code(400);
        echo json_encode(['error' => 'Missing or invalid songID or userID']);
        exit;
    }

    $sql = "SELECT rating, comment FROM review WHERE songID = ? AND userID = ?";
    $stmt = $conn->prepare($sql);
    $stmt->execute([$songID, $userID]);

    $row = $stmt->get_result()->fetch_assoc();

    if ($row) {
        echo json_encode([
            'exists' => true,
            'rating' => isset($row['rating']) ? (float) $row['rating'] : null,
            'comment' => $row['comment'],
        ]);
    } else {
        echo json_encode([
            'exists' => false,
            'rating' => null,
            'comment' => null,
        ]);
    }
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    $songID = $data['songID'];
    $userID = $data['userID'];
    $rating = $data['rating'] ?? null;
    $comment = $data['comment'] ?? null;

    $sql = "
    INSERT INTO review (songID, userID, rating, comment) VALUES (?, ?, ?, ?)
    ON DUPLICATE KEY UPDATE rating = VALUES(rating), comment = IF(VALUES(comment) IS NULL, comment, VALUES(comment));
    ";

    $stmt = $conn->prepare($sql);
    $stmt->execute([$songID, $userID, $rating, $comment]);

    echo json_encode(['status' => 'success']);
    exit;
}

http_response_code(405);
echo json_encode(['error' => 'Method not allowed']);
exit;