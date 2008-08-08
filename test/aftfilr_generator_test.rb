require File.join(File.dirname(__FILE__), 'test_helper')

class AftfilrGeneratorTest < GeneratorTestCase
  
  # APPTODO: assert_generated_directory - new method for GeneratorTestCase
  
  # Note: Most of these tests are intended not to test the functionality in 
  #       Rails, but to better understand it.
  
  def test_generated_names
    g = build_generator('aftfilr', %w(document))
    assert_equal 'document', g.name
    assert_equal 'document', g.singular_name
    assert_equal 'document', g.file_name # aliased to singular_name
    assert_equal 'documents', g.plural_name
    assert_equal 'documents', g.table_name
    assert_equal [], g.class_path
    assert_equal 'Document', g.class_name
    assert_equal 'Document', g.model_class_name
    assert_equal 'Documents', g.controller_class_name
    assert_equal 'DocumentDialog', g.tinymce_dialog_name
    assert_equal 'Document Manager', g.tinymce_window_title
    assert_equal '/documents', g.controller_index_path
    assert_equal 'CreateDocuments', g.migration_class_name
  end
  
  def test_generated_names_for_capitalized_arg
    g = build_generator('aftfilr', %w(Document))
    assert_equal 'Document', g.name
    assert_equal 'document', g.singular_name
    assert_equal 'documents', g.plural_name
    assert_equal 'documents', g.table_name
    assert_equal [], g.class_path
    assert_equal 'Document', g.class_name
    assert_equal 'Document Manager', g.tinymce_window_title
    assert_equal '/documents', g.controller_index_path
  end
  
  def test_generated_names_for_camelcased_arg
    g = build_generator('aftfilr', %w(GeologyDocument))
    assert_equal 'GeologyDocument', g.name
    assert_equal 'geology_document', g.singular_name
    assert_equal 'geology_documents', g.plural_name
    assert_equal 'geology_documents', g.table_name
    assert_equal [], g.class_path
    assert_equal 'GeologyDocument', g.class_name
    assert_equal 'GeologyDocuments', g.controller_class_name
    # APPTODO: Make below loc pass. Need something like decamelize.
    # assert_equal 'Geology Document Manager', g.tinymce_window_title
    assert_equal '/geology_documents', g.controller_index_path
  end
  
  def test_generated_namespaced_names_with_path_arg
    g = build_generator('aftfilr', %w(admin/document))
    assert_equal 'admin/document', g.name
    assert_equal 'document', g.singular_name
    assert_equal 'documents', g.plural_name
    assert_equal 'admin_documents', g.table_name
    assert_equal %w(admin), g.class_path
    assert_equal 'Admin::Document', g.class_name
    assert_equal 'Admin::Documents', g.controller_class_name
    assert_equal 'admin/document', g.file_path
    assert_equal 'Admin', g.class_nesting
    assert_equal 'Document Manager', g.tinymce_window_title
    assert_equal '/admin/documents', g.controller_index_path
  end
  
  def test_generated_namespaced_names_with_scoped_arg
    g = build_generator('aftfilr', %w(Admin::Document))
    assert_equal 'Admin::Document', g.name
    assert_equal 'document', g.singular_name
    assert_equal 'documents', g.plural_name
    assert_equal 'admin_documents', g.table_name
    assert_equal %w(admin), g.class_path
    assert_equal 'Admin::Document', g.class_name
    assert_equal 'Admin::Documents', g.controller_class_name
    assert_equal '/admin/documents', g.controller_index_path
  end
  
end
