CREATE TABLE artist
    (
        artistID INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255) NOT NULL
    );

CREATE TABLE album_type
    (
        typeID INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(63) NOT NULL
    );

CREATE TABLE album
    (
        albumID INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        artistID INT NOT NULL,
        typeID INT NOT NULL,
        releaseDate DATE NOT NULL,
        rating DECIMAL(2, 1),
        albumCover VARCHAR(255), -- URL
        FOREIGN KEY(artistID) REFERENCES artist(artistID),
        FOREIGN KEY(typeID) REFERENCES album_type(typeID)
    );

CREATE TABLE song
    (
        songID INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        artistID INT NOT NULL,
        albumID INT NOT NULL,
        trackNumber DECIMAL(3, 0) NOT NULL,
        releaseDate DATE NOT NULL,
        rating DECIMAL(2, 1), -- 0-indexed
        spotifyURL VARCHAR(255),
        FOREIGN KEY(artistID) REFERENCES artist(artistID),
        FOREIGN KEY(albumID) REFERENCES album(albumID)
    );

CREATE TABLE genre
    (
        genreID INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255) NOT NULL
    );

CREATE TABLE song_genre
    (
        songID INT,
        genreID INT,
        PRIMARY KEY(songID, genreID)
    );

CREATE TABLE user
    (
        userID INT AUTO_INCREMENT PRIMARY KEY,
        username VARCHAR(255) NOT NULL,
        email VARCHAR(255),
        password VARCHAR(255) NOT NULL, -- hashed
        profilePicture VARCHAR(255), -- URL
        dateJoined TIMESTAMP
    );

CREATE TABLE rating
    (
        ratingID INT AUTO_INCREMENT PRIMARY KEY,
        comment VARCHAR(511),
        userID INT NOT NULL,
        timestamp TIMESTAMP,
        rating DECIMAL(1, 0),
        ratedObjectID INT,
        ratingType VARCHAR(15)
    );

CREATE INDEX idx_rating_song_recent ON rating (ratingType, `timestamp`, ratedObjectID);
