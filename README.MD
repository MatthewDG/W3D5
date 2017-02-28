# ORMellow

ORMellow is a lightweight adaptation of Ruby on Rails' `ActiveRecord::Base`. ORMellow bridges the gap between Ruby objects and a SQLite3 database with SQL query generating Ruby methods. Model classes inherit from SQLObject, relating them to their respective table.

## API

ORMellow provides the following conventional ORM methods that Rails developers know and love:

#### Core ORM methods available in `SQLObject` class
- `::all` - Return an array of all rows in the model's table
- `::find(id)` - Return an object created from the row with the matching id
- `::columns` - Returns an array of column names for the corresponding model.
- `#attributes` - Return a hash of attributes and their respective values for a particular instance
- `#attribute_values` - Return an array of column values for a particular instance
- `#insert` - Add a new row to table representing the given instance
- `#update` - Update the existing row that matches the given instance's id
- `#save` - `#insert` or `#update` based on the model instance's presence in the database
- `#where(params)` - Searches the database table for rows with attributes matching the input params

```
  Dog.where( { name: "Scooter" } )
  #=> [#<Dog:0x007fe5f48adf18 @attributes={:id=>1, :name=>"Scooter", :breed=>"Greyhound", :owner_id=>4}>]
```

#### Associatable

We can relate different models with the following associations:

- `#belongs_to`
- `#has_many`
- `#has_one_through(name, through_name, source_name)`

```
class Person < SQLObject
  has_many :dogs, foreign_key: :owner_id
  belongs_to :house, foreign_key: :house_id
end

class House < SQLObject
  has_many :people, foreign_key: :owner_id
end

class Dog < SQLObject
  belongs_to :owner, foreign_key: :owner_id, class_name: "Person"
  has_one_through :house, :owner, :house
end

Person.all.last.dogs
#=> [#<Dog:0x007fe5f35d0530 @attributes={:id=>1, :name=>"Scooter", :breed=>"Greyhound", :owner_id=>4}>,
 #<Dog:0x007fe5f35d03a0 @attributes={:id=>2, :name=>"Ginger", :breed=>"Greyhound", :owner_id=>4}>]

 Person.all.first.house
 #=> #<House:0x007fe5f34b3468 @attributes={:id=>2, :town=>"New York City"}>

 Dog.all.first.house
 #=> #<House:0x007fe5f33a3ca8 @attributes={:id=>1, :town=>"Middletown"}>
```

## Usage and demo setup

You can get up and running with ORMellow models in just a few easy steps! Reset the `DOGS_SQL_FILE` and `DOGS_DB_FILE` to your database files in `lib/db_connection.rb` to swap in your own database. Require `ormellow.rb` in your project and extend the `SQLObject` class on your model classes. Be sure to call `::finalize` on your class in order to attach the attribute getter and setter methods to the model.

```
Person.finalize!
House.finalize!
Dog.finalize!
```

If you'd like to demo ORMellow with a sample database, require 'dogs_demo.rb' in your script or REPL. After that, you're all set to use the core ORM methods to query the database.
