for SQL in /vagrant/sql/updates/auth/*.sql; do
  echo "Executing $SQL";
  mysql -u root --password="root" auth < $SQL
done

for SQL in /vagrant/sql/updates/characters/*.sql; do
  echo "Executing $SQL";
  mysql -u root --password="root" characters < $SQL
done

for SQL in /vagrant/sql/updates/world/*.sql; do
  echo "Executing $SQL";
  mysql -u root --password="root" world < $SQL
done
