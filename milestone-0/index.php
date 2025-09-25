<!DOCTYPE html>
<html>
<body>

<?php
$servername = "127.0.0.1";
$username   = "music_user";
$password   = "Password0!";
$dbname     = "music_app";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT id, title, artist FROM Albums";
$result = $conn->query($sql);

echo $result->num_rows . " albums in the Albums table<br>";

while ($row = $result->fetch_assoc()) {
  echo $row["id"] . " – " . $row["title"] . " by " . $row["artist"] . "<br>";
}

$conn->close();
?>

</body>
</html>