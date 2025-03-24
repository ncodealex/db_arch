SET GLOBAL time_zone = 'Europe/Moscow';

INSERT INTO mysql.user (Host, User, Password)
VALUES ('%', '$MYSQL_ROOT_USER', password('$MYSQL_ROOT_USER'));
GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION;
