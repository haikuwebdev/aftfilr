class AftfilrGenerator < Rails::Generator::NamedBase
  default_options :with_categories => false, :skip_migration => false
  
  attr_reader   :controller_name,
                :controller_class_path,
                :controller_file_path,
                :controller_class_nesting,
                :controller_class_nesting_depth,
                :controller_class_name,
                :controller_underscore_name,
                :controller_singular_name,
                :controller_plural_name
  alias_method  :controller_file_name,  :controller_underscore_name
  alias_method  :controller_table_name, :controller_plural_name

  def initialize(runtime_args, runtime_options = {})
    super

    if @name == @name.pluralize && !options[:force_plural]
      logger.warning "Plural version of the model detected, using singularized version.  Override with --force-plural."
      @name = @name.singularize
    end

    @controller_name = @name.pluralize

    base_name, @controller_class_path, @controller_file_path, @controller_class_nesting, @controller_class_nesting_depth = extract_modules(@controller_name)
    @controller_class_name_without_nesting, @controller_underscore_name, @controller_plural_name = inflect_names(base_name)
    @controller_singular_name=base_name.singularize
    if @controller_class_nesting.empty?
      @controller_class_name = @controller_class_name_without_nesting
    else
      @controller_class_name = "#{@controller_class_nesting}::#{@controller_class_name_without_nesting}"
    end
  end
  
  def manifest
    record do |m|
      # APPTODO: Check for class collisions
      
      
      # Models
      m.directory(File.join('app/models', class_path))
      m.template 'models/attfu_model.rb', File.join('app/models', class_path, "#{singular_name}.rb")
      m.template 'models/category_model.rb', "app/models/#{singular_name}_category.rb" if options[:with_categories]
      
      # Controllers
      m.directory(File.join('app/controllers', controller_class_path))
      m.template('controllers/aftfilr_controller.rb', 
                 File.join('app/controllers', controller_class_path, "#{controller_file_name}_controller.rb"))
      
      # TinyMCE plugin
      m.directory(tinymce_plugin_dir)
      m.template 'tinymce_plugin/dialog.htm', File.join(tinymce_plugin_dir, 'dialog.htm')
      m.template 'tinymce_plugin/editor_plugin.js', File.join(tinymce_plugin_dir, 'editor_plugin.js')
      m.directory(File.join(tinymce_plugin_dir, 'css'))
      m.file 'tinymce_plugin/css/aftfilr.css', File.join(tinymce_plugin_dir, 'css', "#{singular_name}.css")
      m.directory(File.join(tinymce_plugin_dir, 'img'))
      m.file 'tinymce_plugin/img/aftfilr.png', File.join(tinymce_plugin_dir, 'img', "#{singular_name}.png")
      m.file 'tinymce_plugin/img/category.png', File.join(tinymce_plugin_dir, 'img', "category.png")
      m.directory(File.join(tinymce_plugin_dir, 'js'))
      m.template 'tinymce_plugin/js/dialog.js', File.join(tinymce_plugin_dir, 'js', "dialog.js")
      m.directory(File.join(tinymce_plugin_dir, 'langs'))
      m.template 'tinymce_plugin/langs/en.js', File.join(tinymce_plugin_dir, 'langs', "en.js")
      m.template 'tinymce_plugin/langs/en_dlg.js', File.join(tinymce_plugin_dir, 'langs', "en_dlg.js")
      m.file 'tinymce_plugin/img/document_icon.png', File.join('public', 'images', 'document_icon.png')
      
      # Migrations
      unless options[:skip_migration]
        m.migration_template 'migrations/attfu_migration.rb', 'db/migrate',
                             :assigns => { :migration_class_name => migration_class_name },
                             :migration_file_name => "create_#{table_name}"
      end
      
      # Views
      m.directory(File.join('app/views', controller_class_path, controller_file_name))
      m.template 'views/_document.html.erb', File.join(views_dir, '_document.html.erb')
      m.template 'views/new.html.erb', File.join(views_dir, 'new.html.erb')
      m.template 'views/index.html.erb', File.join(views_dir, 'index.html.erb')
      
      # Routes
      m.route_resources controller_file_name
      
    end
  end
  
  alias_method :model_class_name, :class_name
  
  def tinymce_plugin_dir
    File.join('public/javascripts/tinymce/jscripts/tiny_mce/plugins', singular_name)
  end
  
  def tinymce_dialog_name
    class_name + 'Dialog'
  end
  
  def tinymce_window_title
    class_name.demodulize + ' Manager'
  end
  
  def controller_index_path
    class_path.empty? ? "/#{plural_name}" : "/#{class_path.join('/')}/#{plural_name}"
  end
  
  def migration_class_name
    "Create#{controller_class_name}"
  end
  
  def views_dir
    File.join('app/views', controller_class_path, controller_file_name)
  end
  
  def category_singular_name
    singular_name + '_category'
  end
  
  def categories_migration_name
    "Create#{model_class_name}Categories"
  end
  
  def categories_table_name
    "#{singular_name}_categories"
  end
  
  def category_class_name
    "#{model_class_name}Category"
  end
  
  protected
  
  def add_options!(opt)
    opt.separator ''
    opt.separator 'Options:'
    opt.on("--skip-migration",
           "Do not generate migrations for any models.") { |v| options[:skip_migration] = v }
    opt.on("--with-categories",
           "Add categories to be associated with the generated model.") { |v| options[:with_categories] = v }
  end
  
end
