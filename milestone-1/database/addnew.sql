INSERT INTO artist (name)
VALUES (:name_parameter);

INSERT INTO album (name, artistID, typeID, releaseDate, albumCover)
VALUES (:name_parameter, :artist_parameter, :type_parameter, :date_parameter, :cover_parameter)
;

INSERT INTO album (name, artistID, typeID, releaseDate)
VALUES (:name_parameter, :artist_parameter, :type_parameter, :date_parameter)
;

INSERT INTO song (name, albumID, artistID, trackNumber, releaseDate)
VALUES (:name_parameter, :album_parameter, :artist_parameter, :track_parameter, :date_parameter)
; -- ????

INSERT INTO song_genres (songID, genreID)
VALUES (:song_parameter, :genre_parameter)
;

-- how to add authorization?