class <%= model_class_name %> < ActiveRecord::Base
  has_attachment :storage => :file_system
end