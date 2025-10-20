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
        FOREIGN KEY(albumID) REFERENCES album(albumID),
        UNIQUE (albumID, trackNumber)
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
        PRIMARY KEY(songID, genreID),
        FOREIGN KEY(songID) REFERENCES song(songID) ON DELETE CASCADE,
        FOREIGN KEY(genreID) REFERENCES genre(genreID) ON DELETE CASCADE
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

CREATE TABLE review
    (
        reviewID INT AUTO_INCREMENT PRIMARY KEY,
        userID INT NOT NULL,
        songID INT NOT NULL,
        rating DECIMAL(1, 0) NOT NULL,
        comment VARCHAR(511),
        timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

        FOREIGN KEY(userID) REFERENCES user(userID) ON DELETE CASCADE,
        FOREIGN KEY(songID) REFERENCES song(songID) ON DELETE CASCADE,
        UNIQUE (userID, songID),
        CHECK (rating BETWEEN 1 AND 5)
    );

CREATE INDEX idx_review_song_recent ON review (songID, timestamp);
