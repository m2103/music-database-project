USE music_app;

SELECT 'R6: Highest Average Rating in Past 7 Days' as ______________;
WITH week_stats AS (
  SELECT
    r.songID,
    AVG(r.rating) AS avg_7days,
    COUNT(*) AS ratings_7days
  FROM review r
  WHERE r.timestamp >= NOW() - INTERVAL 7 DAY
  GROUP BY r.songID
),
lifetime_stats AS (
  SELECT
    r.songID,
    AVG(r.rating) AS avg_alltime,
    COUNT(*) AS ratings_alltime
  FROM review r
  GROUP BY r.songID
)
SELECT
  s.songID,
  s.name AS title,
  a.name AS artist_name,
  lt.avg_alltime AS avg_rating,
  lt.ratings_alltime AS ratings_count
FROM week_stats ws
JOIN lifetime_stats lt ON lt.songID = ws.songID
JOIN song s ON s.songID = ws.songID
JOIN artist a ON a.artistID = s.artistID
WHERE ws.ratings_7days >= 1
ORDER BY ws.avg_7days DESC, ws.ratings_7days DESC, s.name ASC
LIMIT 10;

WITH week_stats AS (
  SELECT
    r.songID,
    AVG(r.rating) AS avg_7days,
    COUNT(*) AS ratings_7days
  FROM review r
  WHERE r.timestamp >= NOW() - INTERVAL 7 DAY
  GROUP BY r.songID
),
lifetime_stats AS (
  SELECT
    r.songID,
    AVG(r.rating) AS avg_alltime,
    COUNT(*) AS ratings_alltime
  FROM review r
  GROUP BY r.songID
)
SELECT
  s.songID,
  s.name AS title,
  a.name AS artist_name,
  lt.avg_alltime AS avg_rating,
  lt.ratings_alltime AS ratings_count
FROM week_stats ws
JOIN lifetime_stats lt ON lt.songID = ws.songID
JOIN song s ON s.songID = ws.songID
JOIN artist a ON a.artistID = s.artistID
WHERE ws.ratings_7days >= 1
ORDER BY ws.ratings_7days DESC, s.name ASC
LIMIT 10;

SELECT 'R7: View Song Details' as ______________;
SELECT 
    s.name AS song_name,
    a.name AS artist_name,
    AVG(r.rating) AS song_rating,
    ab.name AS album_name,
    s.releaseDate AS song_date, 
    s.spotifyURL AS song_url,
    GROUP_CONCAT(g.name SEPARATOR ', ') AS genres
FROM 
    song AS s
    JOIN artist AS a ON s.artistID = a.artistID
    JOIN album AS ab ON s.albumID = ab.albumID
    LEFT JOIN song_genre AS sg ON s.songID = sg.songID
    LEFT JOIN genre AS g ON sg.genreID = g.genreID
    LEFT JOIN review AS r ON s.songID = r.songID 
WHERE 
    s.songID = 15;  -- when a user clicks on a song,
                  --    the songID of that song gets passed
                  --    into this query so that we display
                  --    the correct song.

SELECT 'R8: Submitting a review' as ______________;
INSERT INTO review (userID, songID, rating, comment)
VALUES (2, 5, 4, 'my favourite!');

SELECT 'R9: View User Profile' as ______________;
SELECT 
    username AS userName,
    email,
    profilePicture,
    DATE_FORMAT(dateJoined, '%Y-%m-%d') AS dateJoined
FROM user
WHERE userID = 1;