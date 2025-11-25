USE music_app;

SELECT 'R6: View Song Details' as ______________;
SELECT
    s.songID,
    s.songName,
    s.artists,
    s.releaseDate,
    s.spotifyURL,
    s.albumName,
    s.albumCover,
    s.avgRating,
    s.reviewCount
FROM song_summary s
WHERE s.songID = 1;

SELECT 'R7: Submitting a review' as ______________;
INSERT INTO review (userID, songID, rating, comment)
VALUES (2, 5, 4, 'my favourite!');

SELECT 'R8: View User Details' as ______________;
SELECT 
    username AS userName,
    email,
    profilePicture,
    DATE_FORMAT(dateJoined, '%Y-%m-%d') AS dateJoined
FROM user
WHERE userID = 1;

SELECT 'R9: Viewing a Song’s Recent Reviews' as ______________;
SELECT 
    u.username AS userName,
    r.rating,
    r.comment,
    r.timestamp
FROM review r
JOIN user u ON u.userID = r.userID
WHERE r.songID = 1
ORDER BY r.timestamp DESC
LIMIT 20;

SELECT 'R10: Viewing a User’s Recent Reviews' as ______________;
SELECT
    JSON_ARRAYAGG(review_obj) AS recentReviews
FROM (
    SELECT JSON_OBJECT(
        'reviewID', r.reviewID,
        'rating', r.rating,
        'comment', r.comment,
        'timestamp', DATE_FORMAT(r.timestamp, '%Y-%m-%d'),

        'songID', s.songID,
        'songName', s.name,

        'albumID', a.albumID,
        'albumName', a.name,

        'artists', (
            SELECT GROUP_CONCAT(ar.name ORDER BY ar.name SEPARATOR ', ')
            FROM song_artist sa
            JOIN artist ar ON ar.artistID = sa.artistID
            WHERE sa.songID = s.songID
        )
    ) AS review_obj
    FROM review r
    JOIN song s        ON s.songID = r.songID
    JOIN album a       ON a.albumID = s.albumID
    WHERE r.userID = 1
    ORDER BY r.timestamp DESC
    LIMIT 5
) AS recent_reviews;
