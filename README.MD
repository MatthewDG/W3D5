# ORMellow

ORMellow is a lightweight adaptation of Ruby on Rails' `ActiveRecord::Base`. ORMellow bridges the gap between Ruby objects and a SQLite3 database with SQL query generating Ruby methods allowing for concise model classes.

## API

ORMellow provides the following conventional ORM methods that Rails developers know and love:

#### Core ORM methods available in `SQLObject` class
- `::all`
- `::find(id)`
- `#insert`
- `#update`
- `#save`
- `#where`

#### Associatable

- `#belongs_to`
- `#has_many`
- `#has_one_through(name, through_name, source_name)`

## Usage and demo setup

You can get up and running with ORMellow models in just a few easy steps! Reset the `DOGS_SQL_FILE` and `DOGS_DB_FILE` to your database files in `lib/db_connection.rb` to swap in your own database. Require `ormellow.rb` in your project and extend the `SQLObject` class on your model classes. Be sure to end your class definitions with `::finalize!` in order to attach the attribute columns to the model.

If you'd like to demo ORMellow with a sample database, require 'dogs_demo.rb' in your script or REPL. After that, you're all set to use the core ORM methods to query the database.
