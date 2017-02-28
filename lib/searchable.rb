require_relative 'db_connection'
require_relative '01_sql_object'
require 'byebug'
module Searchable
  def where(params)
    table_name = self.table_name
    where_clause = []
    values = []
    params.each do |col, val|
      where_clause << "#{col} = ?"
      values << val
    end

    where_clause = where_clause.join(" AND ")

    found = DBConnection.execute(<<-SQL, values)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{where_clause}
    SQL

    found.map{ |row| self.new(row) }
  end

end

class SQLObject
  extend Searchable
end
