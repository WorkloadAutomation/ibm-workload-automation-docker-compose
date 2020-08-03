echo
echo "WA - starting creation of DB"
echo

chmod 644 /db_tools/create_db.sql
su - db2inst1 -c "db2 -tvf /db_tools/create_db.sql"

echo
echo "WA - creation completed"

