import csv
import mysql.connector

DATA_DIR = "db/data"

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="music_app"
)

cursor = conn.cursor()

def load_artist():
    with open(f"{DATA_DIR}/artist.csv", "r", encoding="utf-8") as f:
        reader = csv.reader(f)
        next(reader)  # Skip header
        for row in reader:
            cursor.execute(
                "INSERT INTO artist (artistID, name) VALUES (%s, %s)",
                (row[0], row[1])
            )
    conn.commit()

def load_album():
    with open(f"{DATA_DIR}/album.csv", "r", encoding="utf-8") as f:
        reader = csv.reader(f)
        next(reader)
        for row in reader:
            release_date = row[2].strip()
            if release_date == "" or release_date == "0000-01-01":
                release_date = None

            cursor.execute(
                "INSERT INTO album (albumID, name, releaseDate, albumCover) VALUES (%s, %s, %s, %s)",
                (row[0], row[1], release_date, row[3])
            )
    conn.commit()

def load_album_artist():
    with open(f"{DATA_DIR}/album_artist.csv", "r", encoding="utf-8") as f:
        reader = csv.reader(f)
        next(reader)
        for row in reader:
            cursor.execute(
                "INSERT INTO album_artist (albumID, artistID) VALUES (%s, %s)",
                (row[0], row[1])
            )
    conn.commit()

def load_song():
    with open(f"{DATA_DIR}/song.csv", "r", encoding="utf-8") as f:
        reader = csv.reader(f)
        next(reader)
        for row in reader:
            release_date = row[4].strip()
            if release_date == "" or release_date == "0000-01-01":
                release_date = None

            cursor.execute(
                "INSERT INTO song (songID, name, albumID, trackNumber, releaseDate, spotifyURL) VALUES (%s, %s, %s, %s, %s, %s)",
                (row[0], row[1], row[2], row[3], release_date, row[5])
            )
    conn.commit()

def load_song_artist():
    with open(f"{DATA_DIR}/song_artist.csv", "r", encoding="utf-8") as f:
        reader = csv.reader(f)
        next(reader)
        for row in reader:
            cursor.execute(
                "INSERT INTO song_artist (songID, artistID) VALUES (%s, %s)",
                (row[0], row[1])
            )
    conn.commit()

def load_user():
    with open(f"{DATA_DIR}/user.csv", "r", encoding="utf-8") as f:
        reader = csv.reader(f)
        next(reader)
        for row in reader:
            cursor.execute(
                "INSERT INTO user (username, email, password, profilePicture, dateJoined) VALUES (%s, %s, %s, %s, %s)",
                (row[0], row[1], row[2], row[3], row[4])
            )
    conn.commit()

import datetime

def load_review():
    with open(f"{DATA_DIR}/review.csv", "r", encoding="utf-8") as f:
        reader = csv.reader(f)
        next(reader)  # Skip header
        for row in reader:
            try:
                user_id = int(row[0].strip())
                song_id = int(row[1].strip())
                rating = float(row[2].strip())
                comment = row[3].strip()
                timestamp_str = row[4].strip()
                timestamp = datetime.datetime.strptime(timestamp_str, "%Y-%m-%d %H:%M:%S")

                cursor.execute(
                    "INSERT INTO review (userID, songID, rating, comment, timestamp) VALUES (%s, %s, %s, %s, %s)",
                    (user_id, song_id, rating, comment, timestamp)
                )
            except Exception as e:
                print("Skipping review row due to error:", row, e)
                continue
    conn.commit()


if __name__ == "__main__":
    load_artist()
    load_album()
    load_album_artist()
    load_song()
    load_song_artist()
    load_user()
    load_review()
    cursor.close()
    conn.close()
    print("Data loading complete.")