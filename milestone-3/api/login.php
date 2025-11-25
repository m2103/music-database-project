<?php
header("Access-Control-Allow-Origin: http://localhost:5173");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

// Handle preflight OPTIONS request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

header('Content-Type: application/json');

// Include your database connection
require __DIR__ . '/db.php';

// Read JSON body
$input = json_decode(file_get_contents('php://input'), true);
$username = $input['username'] ?? '';
$password = $input['password'] ?? '';

if (!$username || !$password) {
    echo json_encode(['error' => 'Username and password are required']);
    exit;
}

// Prepare statement to fetch user by username
$stmt = $conn->prepare("SELECT userID, password FROM user WHERE username = ?");
if (!$stmt) {
    echo json_encode(['error' => 'Database error']);
    exit;
}

$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();
$user = $result->fetch_assoc();

// Check credentials
if (!$user) {
    echo json_encode(['error' => 'Invalid username or password']);
    exit;
}

// Check credentials (raw comparison, insecure) -- for now
if ($password !== $user['password']) {
    echo json_encode(['error' => 'Invalid username or password']);
    exit;
}

/*
// Assuming your passwords are hashed using password_hash()
if (!password_verify($password, $user['password'])) {
    echo json_encode(['error' => 'Invalid username or password']);
    exit;
}
*/

// Successful login
echo json_encode(['userID' => (int)$user['userID']]);
exit;