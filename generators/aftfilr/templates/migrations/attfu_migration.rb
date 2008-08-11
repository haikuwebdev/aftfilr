class <%= migration_class_name %> < ActiveRecord::Migration
  def self.up
    create_table "<%= table_name %>", :force => true do |t|
      t.integer :size
      t.string :content_type
      t.string :filename
      <%- if options[:with_categories] -%>
      t.integer <%= ":#{category_singular_name}_id" %>  
      <%- end -%>
      t.timestamps
    end
  end
  
  def self.down
    drop_table "<%= table_name %>"
  end
end