require File.join(File.dirname(__FILE__), 'test_helper')

class AftfilrGeneratorTinyMcePluginTest < GeneratorTestCase
  
  def setup
    run_generator('aftfilr', %w(document))
  end
  
  def test_tinymce_plugin_dirs_created
    
    assert_generated_file("public/javascripts/tinymce/jscripts/tiny_mce/plugins/document")
    assert_generated_file("public/javascripts/tinymce/jscripts/tiny_mce/plugins/document/css")
    assert_generated_file("public/javascripts/tinymce/jscripts/tiny_mce/plugins/document/img")
    assert_generated_file("public/javascripts/tinymce/jscripts/tiny_mce/plugins/document/js")
    assert_generated_file("public/javascripts/tinymce/jscripts/tiny_mce/plugins/document/langs")
  end
  
  def test_tinymce_plugin_files_created
    assert_generated_file("public/javascripts/tinymce/jscripts/tiny_mce/plugins/document/editor_plugin.js")
    assert_generated_file("public/javascripts/tinymce/jscripts/tiny_mce/plugins/document/css/document.css")
    assert_generated_file("public/javascripts/tinymce/jscripts/tiny_mce/plugins/document/img/document.png")
    assert_generated_file("public/javascripts/tinymce/jscripts/tiny_mce/plugins/document/img/category.png")
    assert_generated_file("public/javascripts/tinymce/jscripts/tiny_mce/plugins/document/js/dialog.js")
    assert_generated_file("public/javascripts/tinymce/jscripts/tiny_mce/plugins/document/langs/en.js")
    assert_generated_file("public/javascripts/tinymce/jscripts/tiny_mce/plugins/document/langs/en_dlg.js")
  end
  
  def test_dialog_content
    assert_generated_file("public/javascripts/tinymce/jscripts/tiny_mce/plugins/document/dialog.htm") do |body|
      assert_match "<title>Document Manager</title>", body
      assert_match /Ajax.Request\(\"\/documents\"/, body, "/documents should be the path arg for Ajax.Request"
    end
  end
  
end
