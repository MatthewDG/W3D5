require_relative 'association_options'

class BelongsToOptions < AssociationOptions

  def initialize(name, options = {})
    default_options = {:class_name => name.to_s.singularize.camelcase,
      :foreign_key => (name.to_s.downcase.underscore + "_id").to_sym,
      :primary_key => :id}

    options = default_options.merge(options)
    @name = name
    @foreign_key = options[:foreign_key]
    @primary_key = options[:primary_key]
    @class_name = options[:class_name]
  end
end
