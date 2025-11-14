USE music_app;

SELECT 'Get User Reviewed Songs (Most Recently Reviewed to Oldest)' as ______________;
SELECT 
    r.reviewID,
    r.userID,
    r.songID,
    s.name AS song_name,
    GROUP_CONCAT(DISTINCT a.name ORDER BY a.name SEPARATOR ', ') AS artist_name,
    r.rating,
    r.comment AS review_comment,
    r.timestamp AS review_timestamp
FROM 
    review AS r
    JOIN song AS s ON r.songID = s.songID
    LEFT JOIN song_artist AS sa ON s.songID = sa.songID
    LEFT JOIN artist AS a ON sa.artistID = a.artistID
WHERE 
    r.userID = 1  -- when viewing a user's profile,
                 --    the userID of that user gets passed
                 --    into this query so that we display
                 --    their reviewed songs.
GROUP BY 
    r.reviewID, r.userID, r.songID, s.name, r.rating, r.comment, r.timestamp
ORDER BY 
    r.timestamp DESC;

