# Milestone 1
## Create and Load Sample Database
### 1. Create the database and user
```
mysql -u root -p

CREATE DATABASE music_app;

CREATE USER 'music_user'@'localhost' IDENTIFIED BY 'Password0!';
GRANT ALL ON music_app.* TO 'music_user'@'localhost';
ALTER USER 'music_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Password0!'

EXIT;
```

### 2. Load the schema and sample data
```
mysql -u music_user -p music_app < database/createtables.sql
mysql -u music_user -p music_app < database/load_sample_data.sql
```

## Run the Application
### 1. Start PHP API
```
php -S 127.0.0.1:8000 -t api
```

### 2. Start the frontend
```
npm run dev
```

## Current Features
- Displays top songs by highest average rating over the past 7 days in the home page
- Displays top songs by most ratings in the past 7 days in the home page
- Other components are currently placeholders without functionality