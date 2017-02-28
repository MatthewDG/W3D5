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
- `#has_one_through`
