-- when we click on a song, we want to see:
--      - song name
--      - the artist
--      - track rating
--      - album it belongs to + cover image
--      - release date
--      - spotify URL
--      - genres

SELECT 
    s.name AS song_name,
    a.name AS artist_name,
    s.rating AS song_rating,
    ab.name AS album_name,
    s.releaseDate AS song_date, 
    s.spotifyURL AS song_url,
    GROUP_CONCAT(g.name SEPARATOR ', ') AS genres
FROM 
    song AS s
    JOIN artist AS a ON s.artistID = a.artistID
    JOIN album AS ab ON s.albumID = ab.albumID
    LEFT JOIN song_genres AS sg ON s.songID = sg.songID
    LEFT JOIN genres AS g ON sg.genreID = g.genreID
WHERE 
    s.songID = ?  -- when a user clicks on a song,
                  --    the songID of that song gets passed
                  --    into this query so that we display
                  --    the correct song.
