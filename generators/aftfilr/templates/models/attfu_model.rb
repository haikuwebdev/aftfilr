class <%= model_class_name %> < ActiveRecord::Base
  <%- if options[:with_categories] -%>
  belongs_to :category, :class_name => '<%= category_model_class_name %>', :foreign_key => '<%= category_singular_name %>_id'
  <%- end -%>
  
  has_attachment :storage => :file_system, :max_size => 10.megabytes
  validates_as_attachment
end