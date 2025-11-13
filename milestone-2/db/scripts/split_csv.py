import pandas as pd

df = pd.read_csv("top_10000_1950-now.csv", encoding="utf-8-sig")
df.columns = [col.strip() for col in df.columns]
df = df.fillna("")

df["Track Name"] = df["Track Name"].replace("", "Unknown")
df["Artist Name(s)"] = df["Artist Name(s)"].replace("", "Unknown")
df["Album Name"] = df["Album Name"].replace("", "Unknown")
df["Album Artist Name(s)"] = df["Album Artist Name(s)"].replace("", "Unknown")

print("Generating CSVs")

artist_set = set()
for artists in pd.concat([df["Artist Name(s)"], df["Album Artist Name(s)"]]):
    for artist in artists.split(","):
        name = artist.strip() if artist.strip() else "Unknown"
        artist_set.add(name)

artist_list = sorted(list(artist_set))
artist_df = pd.DataFrame({"name": artist_list})
artist_df.to_csv("artist.csv", index=False)
artist_map = {name: idx for idx, name in enumerate(artist_list)}

album_unique = df[["Album Name", "Album Artist Name(s)", "Album Release Date", "Album Image URL"]].drop_duplicates()
album_unique["Album Name"] = album_unique["Album Name"].replace("", "Unknown")
album_unique["Album Artist Name(s)"] = album_unique["Album Artist Name(s)"].replace("", "Unknown")

album_df = pd.DataFrame({
    "Album Name": album_unique["Album Name"].values,
    "Album Artist Name(s)": album_unique["Album Artist Name(s)"].values,
    "Album Release Date": album_unique["Album Release Date"].values,
    "Album Image URL": album_unique["Album Image URL"].values
})
album_df.to_csv("album.csv", index=False)
album_keys = list(zip(album_df["Album Name"], album_df["Album Artist Name(s)"]))
album_map = {k: i for i, k in enumerate(album_keys)}

album_artist_rows = []
for _, row in album_df.iterrows():
    album_key = (row["Album Name"], row["Album Artist Name(s)"])
    album_idx = album_map[album_key]
    for artist in row["Album Artist Name(s)"].split(","):
        artist = artist.strip() if artist.strip() else "Unknown"
        album_artist_rows.append({
            "album_index": album_idx,
            "artist_name": artist
        })
album_artist_df = pd.DataFrame(album_artist_rows)
album_artist_df.to_csv("album_artist.csv", index=False)

song_rows = []
for _, row in df.iterrows():
    album_key = (row["Album Name"], row["Album Artist Name(s)"])
    album_idx = album_map.get(album_key, None)
    song_name = row["Track Name"] if row["Track Name"].strip() else "Unknown"
    song_rows.append({
        "name": song_name,
        "album_index": album_idx,
        "trackNumber": row["Track Number"],
        "releaseDate": row["Album Release Date"],
        "spotifyURL": row["Track URI"]
    })

song_df = pd.DataFrame(song_rows)
song_df["releaseDate"] = song_df["releaseDate"].apply(
    lambda x: x + '-01-01' if len(str(x)) == 4 else (x + '-01' if len(str(x)) == 7 else x)
)
song_df.to_csv("song.csv", index=False)

song_artist_rows = []
for _, row in df.iterrows():
    for artist in row["Artist Name(s)"].split(","):
        artist = artist.strip() if artist.strip() else "Unknown"
        song_artist_rows.append({
            "spotifyURL": row["Track URI"],
            "artist_name": artist
        })
song_artist_df = pd.DataFrame(song_artist_rows)
song_artist_df.to_csv("song_artist.csv", index=False)

print("All CSVs created successfully.")
