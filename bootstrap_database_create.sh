echo "Executing drop_mysql.sql";
mysql -u root --password="root" < "/vagrant/sql/create/drop_mysql.sql"

echo "Executing create_mysql.sql";
mysql -u root --password="root" < "/vagrant/sql/create/create_mysql.sql"

echo "Executing auth_database.sql";
mysql -u root --password="root" auth < "/vagrant/sql/base/auth_database.sql"

echo "Executing character_database.sql";
mysql -u root --password="root" characters < "/vagrant/sql/base/character_database.sql"

echo "Executing world_database.sql";
mysql -u root --password="root" world < "/vagrant/sql/base/world_database.sql"
