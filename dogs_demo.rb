require_relative './ormellow.rb'

DBConnection::reset

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

Person.finalize!
House.finalize!
Dog.finalize!
