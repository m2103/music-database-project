<?php
// search for songs by title, artist, or album using full text search
header('Content-Type: application/json');
require __DIR__ . '/db.php';

$searchTerm = isset($_GET['q']) ? $_GET['q'] : '';
