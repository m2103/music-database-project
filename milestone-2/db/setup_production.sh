#!/bin/bash
mysql -u root -e "CREATE DATABASE IF NOT EXISTS music_app; USE music_app;"
mysql -u root music_app < db/drop_tables.sql
mysql -u root music_app < db/create_tables.sql
python3 db/production/load_production.py
mysql -u root music_app < db/create_song_summary.sql
mysql -u root music_app < db/create_views.sql