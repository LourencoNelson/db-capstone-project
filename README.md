# DB Capstone Project

## Importing LittleLemonDB

To import the `LittleLemonDB` database along with all its procedures, follow these steps:

1. Use the `LittleLemonDB_DUMP.sql` file to import the `LittleLemonDB` database.

2. Run the following command in your shell. Replace `root` with your database username if different.

   ```sh
   mysql -u root -p LittleLemonDB < LittleLemonDB_DUMP.sql

3. Use the `SampleData.sql` file to insert some sample data to work with. Run the following command in your shell:

   ```sh
   mysql -u root -p LittleLemonDB < SampleData.sql

### Note: You can find in the modules folders all the files and scripts for all the exercises in the project.