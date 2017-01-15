require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

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
end
