import pandas as pd
import os

DATA_DIR = "../data"
os.makedirs(DATA_DIR, exist_ok=True)

def normalize_date(x):
    x = str(x).strip()
    if len(x) == 4:
        return x + "-01-01"
    if len(x) == 7:
        return x + "-01"
    return x

def clean_artist_name(name):
    name = str(name).strip()
    if not name:
        return "Unknown"
    return name.replace('"', '')

df = pd.read_csv("db/production/top_10000_1950-now.csv", encoding="utf-8-sig")
df.columns = [col.strip() for col in df.columns]
df = df.fillna("")

df["Track Name"] = df["Track Name"].replace("", "Unknown")
df["Artist Name(s)"] = df["Artist Name(s)"].replace("", "Unknown")
df["Album Name"] = df["Album Name"].replace("", "Unknown")
df["Album Artist Name(s)"] = df["Album Artist Name(s)"].replace("", "Unknown")
df["Album Release Date"] = df["Album Release Date"].apply(normalize_date)

print("Generating CSVs")

artist_set = set()
for artists in pd.concat([df["Artist Name(s)"], df["Album Artist Name(s)"]]):
    for artist in artists.split(","):
        artist_set.add(clean_artist_name(artist))

artist_list = sorted(list(artist_set))
artist_df = pd.DataFrame({
    "artistID": list(range(len(artist_list))),
    "name": artist_list
})
artist_df.to_csv("db/data/artist.csv", index=False)
artist_map = {name: idx for idx, name in enumerate(artist_list)}

album_unique = df[["Album Name", "Album Artist Name(s)", "Album Release Date", "Album Image URL"]].drop_duplicates()
album_unique["Album Name"] = album_unique["Album Name"].replace("", "Unknown")
album_unique["Album Artist Name(s)"] = album_unique["Album Artist Name(s)"].replace("", "Unknown")

album_df = pd.DataFrame({
    "albumID": list(range(len(album_unique))),
    "name": album_unique["Album Name"].values,
    "releaseDate": album_unique["Album Release Date"].values,
    "albumCover": album_unique["Album Image URL"].values
})
album_df.to_csv("db/data/album.csv", index=False)

album_keys = list(zip(album_df["name"], album_unique["Album Artist Name(s)"]))
album_map = {k: i for i, k in enumerate(album_keys)}

album_artist_rows = []
for _, row in album_unique.iterrows():
    album_key = (row["Album Name"], row["Album Artist Name(s)"])
    album_id = album_map[album_key]

    # Split + clean + remove duplicates
    artists = row["Album Artist Name(s)"].split(",")
    artists = {clean_artist_name(a) for a in artists}  # use set

    for artist_name in artists:
        artist_id = artist_map[artist_name]
        album_artist_rows.append((album_id, artist_id))

# Deduplicate final list
album_artist_df = pd.DataFrame(
    list(set(album_artist_rows)),
    columns=["albumID", "artistID"]
)

album_artist_df.to_csv("db/data/album_artist.csv", index=False)

song_rows = []
for _, row in df.iterrows():
    album_key = (row["Album Name"], row["Album Artist Name(s)"])
    album_idx = album_map.get(album_key, None)
    song_name = row["Track Name"] if row["Track Name"].strip() else "Unknown"
    song_rows.append({
        "name": song_name,
        "albumID": album_idx,
        "trackNumber": row["Track Number"],
        "releaseDate": row["Album Release Date"],
        "spotifyURL": row["Track URI"]
    })

song_df = pd.DataFrame(song_rows)
song_df["releaseDate"] = song_df["releaseDate"].apply(normalize_date)
song_df.insert(0, "songID", list(range(len(song_df))))
song_df.to_csv("db/data/song.csv", index=False)

song_map = {row["spotifyURL"]: row["songID"] for _, row in song_df.iterrows()}

song_artist_rows = []
for _, row in df.iterrows():
    song_id = song_map[row["Track URI"]]

    artists = row["Artist Name(s)"].split(",")
    artists = {clean_artist_name(a) for a in artists}

    for artist_name in artists:
        artist_id = artist_map[artist_name]
        song_artist_rows.append((song_id, artist_id))

song_artist_df = pd.DataFrame(
    list(set(song_artist_rows)),
    columns=["songID", "artistID"]
)

song_artist_df.to_csv("db/data/song_artist.csv", index=False)

print("All CSVs created successfully.")
