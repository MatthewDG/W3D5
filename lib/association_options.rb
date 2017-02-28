class AssociationOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key,
    :name
  )

  def model_class
    self.class_name.constantize
  end

  def table_name
    self.model_class.table_name
  end
end
