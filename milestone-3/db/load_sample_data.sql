-- ------------------------------
-- Artists
-- ------------------------------
INSERT INTO artist (artistID, name) VALUES
(1,'The Weeknd'),
(2,'Dua Lipa'),
(3,'Imagine Dragons'),
(4,'Billie Eilish'),
(5,'Coldplay');

-- ------------------------------
-- Albums
-- ------------------------------
INSERT INTO album (albumID, name, releaseDate, albumCover) VALUES
(1,'After Hours','2020-03-20','https://example.com/afterhours.jpg'),
(2,'Dawn FM','2022-01-07','https://example.com/dawnfm.jpg'),
(3,'Future Nostalgia','2020-03-27','https://example.com/futurenostalgia.jpg'),
(4,'Evolve','2017-06-23','https://example.com/evolve.jpg'),
(5,'Happier Than Ever','2021-07-30','https://example.com/happier.jpg'),
(6,'Everyday Life','2019-11-22','https://example.com/everydaylife.jpg');

-- ------------------------------
-- Album Artist (many-to-many)
-- ------------------------------
INSERT INTO album_artist (albumID, artistID) VALUES
(1,1),
(2,1),
(3,2),
(4,3),
(5,4),
(6,5);

-- ------------------------------
-- Songs
-- ------------------------------
INSERT INTO song (songID, name, albumID, trackNumber, releaseDate, spotifyURL) VALUES
(1,'Blinding Lights',1,1,'2019-11-29','https://open.spotify.com/track/blindinglights'),
(2,'Save Your Tears',1,2,'2020-03-20','https://open.spotify.com/track/saveyourtears'),
(3,'Heartless',1,3,'2019-11-27','https://open.spotify.com/track/heartless'),
(4,'In Your Eyes',1,4,'2020-03-20','https://open.spotify.com/track/inyoureyes'),
(5,'Take My Breath',2,1,'2021-08-06','https://open.spotify.com/track/takemybreath'),
(6,'Levitating',3,1,'2020-03-27','https://open.spotify.com/track/levitating'),
(7,'Don''t Start Now',3,2,'2019-10-31','https://open.spotify.com/track/dontstartnow'),
(8,'Physical',3,3,'2020-01-31','https://open.spotify.com/track/physical'),
(9,'Believer',4,1,'2017-02-01','https://open.spotify.com/track/believer'),
(10,'Thunder',4,2,'2017-04-27','https://open.spotify.com/track/thunder'),
(11,'Something Just Like This',4,3,'2017-02-22','https://open.spotify.com/track/somethingjustlikethis'),
(12,'Happier Than Ever',5,1,'2021-07-30','https://open.spotify.com/track/happierthanever'),
(13,'Bad Guy',5,2,'2019-03-29','https://open.spotify.com/track/badguy'),
(14,'Therefore I Am',5,3,'2020-11-12','https://open.spotify.com/track/thereforeiam'),
(15,'Orphans',6,1,'2019-10-24','https://open.spotify.com/track/orphans'),
(16,'Everyday Life',6,2,'2019-11-22','https://open.spotify.com/track/everydaylife'),
(17,'Church',6,3,'2019-11-22','https://open.spotify.com/track/church'),
(18,'Higher Power',6,4,'2021-05-07','https://open.spotify.com/track/higherpower'),
(19,'Save Your Soul',2,2,'2022-01-07','https://open.spotify.com/track/saveyoursoul'),
(20,'Break My Heart',3,4,'2020-03-25','https://open.spotify.com/track/breakmyheart'),
(21,'Natural',4,4,'2018-07-17','https://open.spotify.com/track/natural'),
(22,'Billie Bossa Nova',5,4,'2021-07-30','https://open.spotify.com/track/billiebossa'),
(23,'Adventure of a Lifetime',6,5,'2015-11-06','https://open.spotify.com/track/adventureofalifetime'),
(24,'Blinding Hearts',2,3,'2022-01-07','https://open.spotify.com/track/blindinghearts'),
(25,'Fever',3,5,'2020-03-27','https://open.spotify.com/track/fever');

-- ------------------------------
-- Song Artist (many-to-many)
-- ------------------------------
INSERT INTO song_artist (songID, artistID) VALUES
(1,1),(2,1),(3,1),(4,1),(5,1),
(6,2),(7,2),(8,2),(20,2),(19,2),
(9,3),(10,3),(11,3),(21,3),(15,3),
(12,4),(13,4),(14,4),(22,4),(16,4),
(17,5),(18,5),(23,5),(24,2),(25,3);

-- ------------------------------
-- Users
-- ------------------------------
INSERT INTO user (username, name, email, password, profilePicture, dateJoined) VALUES
('alice', 'Alice Smith', 'alice@email.com','hashedpwd1','https://example.com/alice.jpg','2025-10-01 10:00:00'),
('bob','Bob Lee','bob@email.com','hashedpwd2','https://example.com/bob.jpg','2025-10-10 11:00:00'),
('charlie','Charlie Brown','charlie@email.com','hashedpwd3','https://example.com/charlie.jpg','2025-10-12 12:00:00'),
('dave','Dave Thompson','dave@email.com','hashedpwd4','https://example.com/dave.jpg','2025-10-14 14:00:00'),
('eve','Eve Johnson','eve@email.com','hashedpwd5','https://example.com/eve.jpg','2025-10-18 09:00:00'),
('frank','Frank Wilson','frank@email.com','hashedpwd6','https://example.com/frank.jpg','2025-09-28 15:00:00'),
('grace', 'Grace Miller','grace@email.com','hashedpwd7','https://example.com/grace.jpg','2025-10-02 12:00:00'),
('hank', 'Hank Davis','hank@email.com','hashedpwd8','https://example.com/hank.jpg','2025-10-05 17:00:00'),
('irene', 'Irene Martinez','irene@email.com','hashedpwd9','https://example.com/irene.jpg','2025-10-07 08:00:00'),
('jack','Jack Wilson','jack@email.com','hashedpwd10','https://example.com/jack.jpg','2025-10-09 20:00:00');

-- ------------------------------
-- Reviews
-- ------------------------------
INSERT INTO review (userID, songID, rating, comment, timestamp) VALUES
('1',1,5,'Amazing song!','2025-10-19 10:00:00'),
('3',3,4,'Pretty good.','2025-10-10 12:00:00'),
('5',3,5,'Fantastic track!','2025-10-18 09:30:00'),
('6',4,5,'This is my favorite!','2025-10-17 20:00:00'),
('8',6,3,'Could be better.','2025-10-12 11:00:00'),
('9',7,5,'Excellent production.','2025-10-11 10:00:00'),
('10',8,5,'Love the energy!','2025-10-18 13:00:00'),
('1',9,4,'Catchy chorus!','2025-10-19 09:30:00'),
('2',10,5,'Smooth vocals.','2025-10-14 16:00:00'),
('3',11,4,'Classic hit.','2025-10-13 15:00:00'),
('4',12,4,'Great beat.','2025-10-12 10:00:00'),
('5',13,5,'On repeat!','2025-10-16 08:00:00'),
('6',14,4,'Perfect for party.','2025-10-15 19:00:00'),
('7',15,5,'Beautiful lyrics.','2025-10-11 21:00:00'),
('8',16,4,'Love the melody.','2025-10-13 09:00:00'),
('9',17,5,'Soothing track.','2025-10-17 12:00:00'),
('10',18,5,'Energetic beat!','2025-10-19 08:00:00'),
('1',19,5,'Amazing production!','2025-10-18 17:00:00'),
('2',20,4,'Cool vibes.','2025-10-17 14:00:00'),
('3',21,4,'Good remix.','2025-10-16 09:30:00'),
('4',22,5,'Nice harmony.','2025-10-15 11:00:00'),
('5',23,5,'Perfect vocals.','2025-10-14 10:00:00'),
('6',24,4,'Awesome song!','2025-10-13 13:00:00'),
('8',3,4,'Very catchy.','2025-10-11 12:00:00'),
('9',4,5,'Love the lyrics.','2025-10-10 16:00:00'),
('1',6,5,'Incredible!','2025-10-08 14:00:00'),
('2',7,4,'Smooth beat.','2025-10-07 11:00:00'),
('3',8,5,'Fantastic!','2025-10-06 15:00:00'),
('4',9,4,'So good!','2025-10-05 17:00:00'),
('5',10,5,'Hits all the notes.','2025-10-04 13:00:00'),
('6',11,5,'Best track ever.','2025-10-03 12:00:00'),
('7',12,4,'Love it!','2025-10-02 09:00:00'),
('8',13,5,'My favorite song.','2025-10-01 18:00:00'),
('9',14,5,'Highly recommend.','2025-09-30 10:00:00'),
('10',15,5,'Amazing!','2025-09-29 19:00:00'),
('1',16,5,'Top track!','2025-09-28 14:00:00'),
('2',17,4,'Beautiful tune.','2025-09-27 16:00:00'),
('3',18,5,'Great harmony.','2025-09-26 12:00:00'),
('4',19,4,'Love this one.','2025-09-25 15:00:00'),
('5',20,5,'Perfect mix.','2025-09-24 13:00:00'),
('6',21,5,'Awesome beat.','2025-09-23 11:00:00'),
('8',22,4,'Excellent!','2025-09-21 10:00:00'),
('9',23,5,'Superb track.','2025-09-20 12:00:00'),
('10',25,4,'Great energy.','2025-09-19 09:00:00');

-- ===========================
-- Script end
-- ===========================
