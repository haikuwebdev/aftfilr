class <%= category_model_class_name %> < ActiveRecord::Base
  has_many :documents, :class_name => '<%= model_class_name %>'

  def self.default
    find(:first)
  end

end
