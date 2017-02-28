require_relative 'association_options'

class HasManyOptions < AssociationOptions
  def initialize(name, self_class_name, options = {})
    default_options = {
      :class_name => name.to_s.singularize.camelcase,
      :foreign_key => (self_class_name.downcase.underscore + "_id").to_sym,
      :primary_key => :id
    }
    options = default_options.merge(options)
    @name = name
    @self_class_name = self_class_name
    @foreign_key = options[:foreign_key]
    @primary_key = options[:primary_key]
    @class_name = options[:class_name]
  end
end
