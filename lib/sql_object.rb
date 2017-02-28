require_relative 'db_connection'
require 'active_support/inflector'

class SQLObject
  attr_accessor :attributes

  def self.columns
    @columns ||= (table_name = self.table_name
    cols = []
    arr = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL

    arr.first.each do |key, value|
       cols << key.to_sym
     end

    @columns = cols)
  end

  def self.finalize!
    self.columns.each do |col|
      define_method(col) do
        attributes[col.to_sym]
      end

      define_method(col.to_s + "=") do |arg|
        attributes[col.to_sym] = arg
      end
    end

  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.to_s.tableize
  end

  def self.all
    table_name = self.table_name
    arr = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
      SQL

    self.parse_all(arr)
  end

  def self.parse_all(results)
    results.map do |params|
      self.new(params)
    end
  end

  def self.find(id)
    table_name = self.table_name
    found = DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        id = (?)
    SQL

    return nil if found.empty?
    self.new(found.first)
  end

  def initialize(params = {})
    params.each do |col,val|
      col = col.to_sym
      raise "unknown attribute '#{col}'" unless self.class.columns.include?(col)
      send("#{col}=", val)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map do |col|
      send("#{col}")
    end
  end

  def insert
    col_names = self.class.columns.join(",")

    question_marks = ["?"] * attribute_values.length
    question_marks = question_marks.join(",")
    table_name = self.class.table_name
    values = attribute_values
    DBConnection.execute(<<-SQL, values)
      INSERT INTO
        #{table_name} (#{col_names})
      VALUES
        (#{question_marks})

    SQL
    self.id = DBConnection.last_insert_row_id
  end

  def update
    table_name = self.class.table_name
    values = attribute_values.drop(1)
    set_clause = self.class.columns.map { |col| "#{col} = ?"}
    set_clause = set_clause.drop(1).join(",")
    sql = DBConnection.execute(<<-SQL, values, id)
      UPDATE
        #{table_name}
      SET
        #{set_clause}
      WHERE
        id = ?
    SQL

  end

  def save
    if id.nil?
      insert
    else
      update
    end
  end
end
