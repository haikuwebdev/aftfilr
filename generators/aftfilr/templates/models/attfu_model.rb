class <%= model_class_name %> < ActiveRecord::Base
  has_attachment :storage => :file_system, :max_size => 10.megabytes
  validates_as_attachment
end