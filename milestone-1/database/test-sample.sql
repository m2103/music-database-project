USE music_app;

SELECT 'R6: Highest Average Rating in Past 7 Days' as ______________;
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
WHERE ws.ratings_7days >= 1
ORDER BY ws.avg_7days DESC, ws.ratings_7days DESC, s.name ASC
LIMIT 10;

SELECT 'R7: Most Rated in Past 7 Days' as ______________;
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
LIMIT 10;


SELECT 'R7: View Song Details' as ______________;
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
    LEFT JOIN genres AS g ON sg.genreID = g.genreID
    LEFT JOIN review AS r ON s.songID = r.songID 
WHERE 
    s.songID = 15  -- when a user clicks on a song,
                  --    the songID of that song gets passed
                  --    into this query so that we display
                  --    the correct song.
