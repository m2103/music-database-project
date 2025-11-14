CREATE VIEW song_summary AS
SELECT
  s.songID,
  s.name AS songName,
  al.name AS albumName,
  al.albumCover,
  a.artists,
  s.releaseDate,
  s.spotifyURL,
  sr.avgRating,
  sr.reviewCount
FROM song s
JOIN album al ON al.albumID = s.albumID
LEFT JOIN song_review_summary sr ON sr.songID = s.songID
LEFT JOIN (
  SELECT sa.songID,
         GROUP_CONCAT(DISTINCT ar.name ORDER BY ar.name SEPARATOR ', ') AS artists
  FROM song_artist sa
  JOIN artist ar ON ar.artistID = sa.artistID
  GROUP BY sa.songID
) a ON a.songID = s.songID;