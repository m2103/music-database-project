USE music_app;

SELECT 'Get Song Reviews (Most Recent to Oldest)' as ______________;
SELECT 
    r.reviewID,
    r.userID,
    u.username,
    u.profilePicture,
    r.rating,
    r.comment,
    r.timestamp
FROM 
    review AS r
    JOIN user AS u ON r.userID = u.userID
WHERE 
    r.songID = 15  -- when a user clicks on a song,
                  --    the songID of that song gets passed
                  --    into this query so that we display
                  --    the correct reviews.
ORDER BY 
    r.timestamp DESC;

