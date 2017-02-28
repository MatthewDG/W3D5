require_relative 'searchable'
require_relative 'association_options'
require_relative 'belongs_to_options'
require_relative 'has_many_options'
require 'active_support/inflector'

module Associatable
  def belongs_to(name, options = {})
    options[:class_name] = options[:class_name] || name.to_s.singularize.camelcase
    options = BelongsToOptions.new(name, options)

    assoc_options[name] = options

    define_method(name) do
      target_class = options.model_class
      if options.foreign_key.nil?
        foreign_key = self.send(target_class.to_s.downcase.underscore + "_id") if foreign_key.nil?
      else
        foreign_key = self.send(options.foreign_key)
      end
      target_class.where(:id => foreign_key).first
    end
  end

  def has_many(name, options = {})
    options[:class_name] = options[:class_name] || name.to_s.singularize.camelcase
    options = HasManyOptions.new(name, self.to_s,options)

    define_method(name) do
      target_class = options.model_class
      foreign_key = options.foreign_key
      target_class.where(options.foreign_key => self.id)
    end

  end

  def has_one_through(name, through_name, source_name)

    define_method(name) do
      through_options = self.class.assoc_options[through_name]
      source_options = through_options.model_class.assoc_options[source_name]
      through_obj = self.send(through_options.name)


      through_class_ref = through_obj.send(source_options.foreign_key)
      source_options.class_name.constantize
      .where(:id => through_class_ref).first
    end
  end

  def assoc_options
    @assoc_options ||= {}
  end
end

class SQLObject
  extend Associatable
end
