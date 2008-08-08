tinyMCEPopup.requireLangPack();

var <%= tinymce_dialog_name %> = {
	init : function() {},

	insert : function() {
	  // APPTODO: Set link text, probably through an attribute like filename, which can be overridden in form field
	  link_text = document.forms[0].url.value;
	  link_html = '<a href="' + doc_url + '>' + link_text + '</a>';
		tinyMCEPopup.editor.execCommand('mceInsertContent', false, link_html);
		tinyMCEPopup.close();
	}
};

tinyMCEPopup.onInit.add(<%= tinymce_dialog_name %>.init, <%= tinymce_dialog_name %>);
