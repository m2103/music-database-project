CREATE TABLE song_review_summary (
  songID INT PRIMARY KEY,
  avgRating DECIMAL(3,1) NOT NULL DEFAULT 0.0,
  reviewCount INT NOT NULL DEFAULT 0,
  FOREIGN KEY (songID) REFERENCES song(songID) ON DELETE CASCADE
);

DELIMITER $$

CREATE TRIGGER review_insert
AFTER INSERT ON review
FOR EACH ROW
BEGIN
  INSERT INTO song_review_summary (songID, avgRating, reviewCount)
  VALUES (NEW.songID, NEW.rating, 1)
  ON DUPLICATE KEY UPDATE
    avgRating = ROUND(((avgRating * reviewCount) + NEW.rating) / (reviewCount + 1), 2),
    reviewCount = reviewCount + 1;
END$$

CREATE TRIGGER review_update
AFTER UPDATE ON review
FOR EACH ROW
BEGIN
  IF OLD.rating <> NEW.rating THEN
    UPDATE song_review_summary
    SET avgRating = ROUND(((avgRating * reviewCount) - OLD.rating + NEW.rating) / reviewCount, 2)
    WHERE songID = NEW.songID;
  END IF;
END$$

CREATE TRIGGER review_delete
AFTER DELETE ON review
FOR EACH ROW
BEGIN
  UPDATE song_review_summary
  SET
    reviewCount = reviewCount - 1,
    avgRating = CASE
                  WHEN reviewCount - 1 <= 0 THEN 0.00
                  ELSE ROUND(((avgRating * reviewCount) - OLD.rating) / (reviewCount - 1), 2)
                END
  WHERE songID = OLD.songID;
END$$

DELIMITER ;

INSERT INTO song_review_summary (songID, avgRating, reviewCount)
SELECT songID, ROUND(AVG(rating),2), COUNT(*)
FROM review
GROUP BY songID
ON DUPLICATE KEY UPDATE
  avgRating = VALUES(avgRating),
  reviewCount = VALUES(reviewCount);