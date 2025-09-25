# Milestone 0 - Hello World Application
## 1 - Create the databasde and user
Open a terminal and start MySQL as root:
```
mysql -u root -p
```
Run the following MySQL commands:
```
CREATE DATABASE music_app;

CREATE USER 'music_user'@'localhost' IDENTIFIED BY 'Password0!';
GRANT ALL ON music_app.* TO 'music_user'@'localhost';
ALTER USER 'music_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Password0!';

USE music_app;

CREATE TABLE Albums (
  id INT PRIMARY KEY,
  title VARCHAR(100),
  artist VARCHAR(100)
);

INSERT INTO Albums VALUES
  (1, 'Midnights', 'Taylor Swift'),
  (2, 'After Hours', 'The Weeknd'),
  (3, 'DAMN.', 'Kendrick Lamar');
```

## 2 - Create the PHP file
Save `index.php` in your home directory.

## 3 - Run and test the application
Start PHP:
```
php -S 127.0.0.1:8000
```

Open your browser at:
```
http://127.0.0.1:8000/index.php
```