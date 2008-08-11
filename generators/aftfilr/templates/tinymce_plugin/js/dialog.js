tinyMCEPopup.requireLangPack();

var <%= tinymce_dialog_name %> = {
	init : function() {},

	insert : function(document_url, document_filename) {
	  link_html = '<a href="' + document_url + '>' + document_filename + '</a>';
		tinyMCEPopup.editor.execCommand('mceInsertContent', false, link_html);
		tinyMCEPopup.close();
	}
};

tinyMCEPopup.onInit.add(<%= tinymce_dialog_name %>.init, <%= tinymce_dialog_name %>);
