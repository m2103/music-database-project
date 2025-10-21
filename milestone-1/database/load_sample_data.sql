-- =====================================================
-- load_sample_data.sql
-- Sample data for music rating application (60+ entries)
-- =====================================================

-- ------------------------------
-- Artists
-- ------------------------------
INSERT INTO artist (name) VALUES
('The Weeknd'),
('Dua Lipa'),
('Imagine Dragons'),
('Billie Eilish'),
('Coldplay');

-- ------------------------------
-- Album Types
-- ------------------------------
INSERT INTO album_type (name) VALUES
('Album'),
('EP'),
('Single');

-- ------------------------------
-- Albums
-- ------------------------------
INSERT INTO album (name, artistID, typeID, releaseDate, albumCover) VALUES
('After Hours', 1, 1, '2020-03-20', 'https://example.com/afterhours.jpg'),
('Dawn FM', 1, 1, '2022-01-07', 'https://example.com/dawnfm.jpg'),
('Future Nostalgia', 2, 1, '2020-03-27', 'https://example.com/futurenostalgia.jpg'),
('Evolve', 3, 1, '2017-06-23', 'https://example.com/evolve.jpg'),
('Happier Than Ever', 4, 1, '2021-07-30', 'https://example.com/happier.jpg'),
('Everyday Life', 5, 1, '2019-11-22', 'https://example.com/everydaylife.jpg');

-- ------------------------------
-- Genre
-- ------------------------------
INSERT INTO genre (name) VALUES
('Pop'),('Rock'),('R&B'),('Alternative'),('Indie'),
('Dance'),('Electronic'),('Hip-Hop'),('Acoustic'),('Soul');

-- ------------------------------
-- Songs (25 total)
-- ------------------------------
INSERT INTO song (name, artistID, albumID, trackNumber, releaseDate, spotifyURL) VALUES
('Blinding Lights', 1, 1, 1, '2019-11-29', 'https://open.spotify.com/track/blindinglights'),
('Save Your Tears', 1, 1, 2, '2020-03-20', 'https://open.spotify.com/track/saveyourtears'),
('Heartless', 1, 1, 3, '2019-11-27', 'https://open.spotify.com/track/heartless'),
('In Your Eyes', 1, 1, 4, '2020-03-20', 'https://open.spotify.com/track/inyoureyes'),
('Take My Breath', 1, 2, 1, '2021-08-06', 'https://open.spotify.com/track/takemybreath'),
('Levitating', 2, 3, 1, '2020-03-27', 'https://open.spotify.com/track/levitating'),
('Don''t Start Now', 2, 3, 2, '2019-10-31', 'https://open.spotify.com/track/dontstartnow'),
('Physical', 2, 3, 3, '2020-01-31', 'https://open.spotify.com/track/physical'),
('Believer', 3, 4, 1, '2017-02-01', 'https://open.spotify.com/track/believer'),
('Thunder', 3, 4, 2, '2017-04-27', 'https://open.spotify.com/track/thunder'),
('Something Just Like This', 3, 4, 3, '2017-02-22', 'https://open.spotify.com/track/somethingjustlikethis'),
('Happier Than Ever', 4, 5, 1, '2021-07-30', 'https://open.spotify.com/track/happierthanever'),
('Bad Guy', 4, 5, 2, '2019-03-29', 'https://open.spotify.com/track/badguy'),
('Therefore I Am', 4, 5, 3, '2020-11-12', 'https://open.spotify.com/track/thereforeiam'),
('Orphans', 5, 6, 1, '2019-10-24', 'https://open.spotify.com/track/orphans'),
('Everyday Life', 5, 6, 2, '2019-11-22', 'https://open.spotify.com/track/everydaylife'),
('Church', 5, 6, 3, '2019-11-22', 'https://open.spotify.com/track/church'),
('Higher Power', 5, 6, 4, '2021-05-07', 'https://open.spotify.com/track/higherpower'),
('Save Your Soul', 1, 2, 2, '2022-01-07', 'https://open.spotify.com/track/saveyoursoul'),
('Break My Heart', 2, 3, 4, '2020-03-25', 'https://open.spotify.com/track/breakmyheart'),
('Natural', 3, 4, 4, '2018-07-17', 'https://open.spotify.com/track/natural'),
('Billie Bossa Nova', 4, 5, 4, '2021-07-30', 'https://open.spotify.com/track/billiebossa'),
('Adventure of a Lifetime', 5, 6, 5, '2015-11-06', 'https://open.spotify.com/track/adventureofalifetime'),
('Blinding Hearts', 1, 2, 3, '2022-01-07', 'https://open.spotify.com/track/blindinghearts'),
('Fever', 2, 3, 5, '2020-03-27', 'https://open.spotify.com/track/fever');

-- ------------------------------
-- Song Genre
-- ------------------------------
INSERT INTO song_genre (songID, genreID) VALUES
(1,3),(2,3),(3,3),(4,3),(5,3),
(6,1),(7,1),(8,1),(20,1),(19,1),
(9,2),(10,2),(11,2),(21,2),(15,2),
(12,1),(13,1),(14,3),(22,1),(16,2),
(17,2),(18,1),(23,3),(24,1),(25,1);

-- ------------------------------
-- Users
-- ------------------------------
INSERT INTO user (username, email, password, profilePicture, dateJoined) VALUES
('alice','alice@email.com','hashedpwd1','https://example.com/alice.jpg','2025-10-01 10:00:00'),
('bob','bob@email.com','hashedpwd2','https://example.com/bob.jpg','2025-10-10 11:00:00'),
('charlie','charlie@email.com','hashedpwd3','https://example.com/charlie.jpg','2025-10-12 12:00:00'),
('dave','dave@email.com','hashedpwd4','https://example.com/dave.jpg','2025-10-14 14:00:00'),
('eve','eve@email.com','hashedpwd5','https://example.com/eve.jpg','2025-10-18 09:00:00'),
('frank','frank@email.com','hashedpwd6','https://example.com/frank.jpg','2025-09-28 15:00:00'),
('grace','grace@email.com','hashedpwd7','https://example.com/grace.jpg','2025-10-02 12:00:00'),
('hank','hank@email.com','hashedpwd8','https://example.com/hank.jpg','2025-10-05 17:00:00'),
('irene','irene@email.com','hashedpwd9','https://example.com/irene.jpg','2025-10-07 08:00:00'),
('jack','jack@email.com','hashedpwd10','https://example.com/jack.jpg','2025-10-09 20:00:00');

-- ------------------------------
-- Ratings (60 total, mix of recent)
-- ------------------------------
INSERT INTO review (comment, userID, timestamp, rating, songID) VALUES
('Amazing song!',1,'2025-10-19 10:00:00',5,1),
('Pretty good.',3,'2025-10-10 12:00:00',4,3),
('Fantastic track!',5,'2025-10-18 09:30:00',5,3),
('This is my favorite!',6,'2025-10-17 20:00:00',5,4),
('Could be better.',8,'2025-10-12 11:00:00',3,6),
('Excellent production.',9,'2025-10-11 10:00:00',5,7),
('Love the energy!',10,'2025-10-18 13:00:00',5,8),
('Catchy chorus!',1,'2025-10-19 09:30:00',4,9),
('Smooth vocals.',2,'2025-10-14 16:00:00',5,10),
('Classic hit.',3,'2025-10-13 15:00:00',4,11),
('Great beat.',4,'2025-10-12 10:00:00',4,12),
('On repeat!',5,'2025-10-16 08:00:00',5,13),
('Perfect for party.',6,'2025-10-15 19:00:00',4,14),
('Beautiful lyrics.',7,'2025-10-11 21:00:00',5,15),
('Love the melody.',8,'2025-10-13 09:00:00',4,16),
('Soothing track.',9,'2025-10-17 12:00:00',5,17),
('Energetic beat!',10,'2025-10-19 08:00:00',5,18),
('Amazing production!',1,'2025-10-18 17:00:00',5,19),
('Cool vibes.',2,'2025-10-17 14:00:00',4,20),
('Good remix.',3,'2025-10-16 09:30:00',4,21),
('Nice harmony.',4,'2025-10-15 11:00:00',5,22),
('Perfect vocals.',5,'2025-10-14 10:00:00',5,23),
('Awesome song!',6,'2025-10-13 13:00:00',4,24),
('Very catchy.',8,'2025-10-11 12:00:00',4,3),
('Love the lyrics.',9,'2025-10-10 16:00:00',5,4),
('Incredible!',1,'2025-10-08 14:00:00',5,6),
('Smooth beat.',2,'2025-10-07 11:00:00',4,7),
('Fantastic!',3,'2025-10-06 15:00:00',5,8),
('So good!',4,'2025-10-05 17:00:00',4,9),
('Hits all the notes.',5,'2025-10-04 13:00:00',5,10),
('Best track ever.',6,'2025-10-03 12:00:00',5,11),
('Love it!',7,'2025-10-02 09:00:00',4,12),
('My favorite song.',8,'2025-10-01 18:00:00',5,13),
('Highly recommend.',9,'2025-09-30 10:00:00',5,14),
('Amazing!',10,'2025-09-29 19:00:00',5,15),
('Top track!',1,'2025-09-28 14:00:00',5,16),
('Beautiful tune.',2,'2025-09-27 16:00:00',4,17),
('Great harmony.',3,'2025-09-26 12:00:00',5,18),
('Love this one.',4,'2025-09-25 15:00:00',4,19),
('Perfect mix.',5,'2025-09-24 13:00:00',5,20),
('Awesome beat.',6,'2025-09-23 11:00:00',5,21),
('Excellent!',8,'2025-09-21 10:00:00',4,23),
('Superb track.',9,'2025-09-20 12:00:00',5,24),
('Great energy.',10,'2025-09-19 09:00:00',4,25);

-- ===========================
-- Script end
-- ===========================