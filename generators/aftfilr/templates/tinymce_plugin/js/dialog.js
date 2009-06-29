tinyMCEPopup.requireLangPack();

var <%= tinymce_dialog_name %> = {
	init : function() {},

	insert : function(document_url) {
	  var link_content = tinyMCEPopup.editor.selection.getContent();
	  var link_html = '<a href="' + document_url + '">' + link_content + '</a>';
		tinyMCEPopup.editor.execCommand('mceInsertContent', false, link_html);
		tinyMCEPopup.close();
	}
};

tinyMCEPopup.onInit.add(<%= tinymce_dialog_name %>.init, <%= tinymce_dialog_name %>);
