CREATE TABLE artist (
    artistID INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    FULLTEXT(name)
);

CREATE TABLE album (
    albumID INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    FULLTEXT(name),
    releaseDate DATE,
    albumCover VARCHAR(255) -- URL
);

CREATE TABLE album_artist (
    albumID INT NOT NULL,
    artistID INT NOT NULL,
    PRIMARY KEY (albumID, artistID),
    FOREIGN KEY (albumID) REFERENCES album(albumID) ON DELETE CASCADE,
    FOREIGN KEY (artistID) REFERENCES artist(artistID) ON DELETE CASCADE
);

CREATE TABLE song (
    songID INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    FULLTEXT(name),
    albumID INT NOT NULL,
    trackNumber INT,
    releaseDate DATE,
    spotifyURL VARCHAR(255),
    FOREIGN KEY (albumID) REFERENCES album(albumID) ON DELETE CASCADE
);

CREATE TABLE song_artist (
    songID INT NOT NULL,
    artistID INT NOT NULL,
    PRIMARY KEY (songID, artistID),
    FOREIGN KEY (songID) REFERENCES song(songID) ON DELETE CASCADE,
    FOREIGN KEY (artistID) REFERENCES artist(artistID) ON DELETE CASCADE
);

CREATE TABLE user (
    userID INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    FULLTEXT(username, name),
    email VARCHAR(255),
    password VARCHAR(255) NOT NULL, -- hashed
    profilePicture VARCHAR(255), -- URL
    dateJoined TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE review (
    reviewID INT AUTO_INCREMENT PRIMARY KEY,
    userID INT NOT NULL,
    songID INT NOT NULL,
    rating DECIMAL(2,1) NOT NULL,
    comment VARCHAR(511),
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (userID) REFERENCES user(userID) ON DELETE CASCADE,
    FOREIGN KEY (songID) REFERENCES song(songID) ON DELETE CASCADE,
    UNIQUE (userID, songID),
    CHECK (rating BETWEEN 1 AND 5)
);

CREATE INDEX idx_review_song_recent ON review (songID, timestamp);
