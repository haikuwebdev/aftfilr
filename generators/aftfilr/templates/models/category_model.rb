class <%= category_model_class_name %> < ActiveRecord::Base
  has_many :<%= plural_name %>

  def self.default
    find(:first)
  end

end
