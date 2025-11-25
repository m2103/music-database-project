# Sample Data
To create and load the sample database, run:
```
bash db/setup_sample.sh
```
This script:
1. Creates the `music_app` database
2. Drops any existing tables (`drop_tables.sql`)
3. Recreates all tables (`create_tables.sql`)
4. Loads sample data into the tables (`load_sample_data.sql`)
5. Creates a song review summary table for better performance (`create_song_summary.sql`)
6. Builds the `song_summary` view (`create_views.sql`)
    
<br />

# Production Data
Download the [top_10000_1950-now.csv](https://www.kaggle.com/datasets/joebeachcapital/top-10000-spotify-songs-1960-now?resource=download) file from Kaggle and place it in the `db/production` directory. To parse the CSV run:
```
python3 db/production/split_csv.py
```
This produces:
```
db/data/artist.csv
db/data/album.csv
db/data/album_artist.csv
db/data/song.csv
db/data/song_artist.csv
```

Then run
```
python3 db/production/generate_user.py
```
to generate users (`db/data/user.csv`) and
```
python3 db/production/generate_review.py
```
to generate reviews (`db/data/review.csv`).

Note that these scripts require the `pandas` and `Faker` libraries.

Finally, run
```
bash db/setup_production.sh
```
which:
1. Creates the `music_app` database
2. Drops any existing tables (`drop_tables.sql`)
3. Recreates all tables (`create_tables.sql`)
4. Loads production data into the tables (`load_production_data.py`)
5. Creates a song review summary table for better performance (`create_song_summary.sql`)
6. Builds the `song_summary` view (`create_views.sql`)

<br />

# Running the Application
Start the PHP backend:
```
php -S 127.0.0.1:8000 -t api
```

Start the React frontend:
```
cd web
npm install
npm run dev
```

The application will be accessible at `http://localhost:5173`.


# Supported Features
1. Viewing song details, including average rating and number of reviews.
2. List of most recent reviews in the song details page.
3. Profile page with user information.