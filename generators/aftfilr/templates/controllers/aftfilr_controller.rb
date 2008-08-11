class <%= controller_class_name %>Controller < ApplicationController
  
  # GET /<%= plural_name %>
  def index
    @documents = <%= model_class_name %>.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.js { index_js }
    end
  end
  
  # GET /<%= plural_name %>/new
  def new
    @<%= singular_name %> = <%= model_class_name %>.new

    respond_to do |format|
      format.html # new.html.erb
      format.js {}
    end
  end
  
  # POST /<%= plural_name %>
  def create
    @<%= singular_name %> = <%= model_class_name %>.new(params[:<%= singular_name %>])
    <%- if options[:with_categories] -%>
    @active_category = @<%= singular_name %>.category
    <%- end -%>
    respond_to do |format|
      if @<%= singular_name %>.save
        flash[:notice] = '<%= model_class_name %> was successfully created.'
        format.html { redirect_to(<%= plural_name %>_url) }
        format.js { responds_to_parent { index_js } }
      else
        format.html { render :action => "new" }
        format.js {}
      end
    end
  end
  
  # GET /<%= plural_name %>/1/edit
  def edit
    @<%= singular_name %> = <%= model_class_name %>.find(params[:id])
  end
  
  # PUT /<%= plural_name %>/1
  def update
    @<%= singular_name %> = <%= model_class_name %>.find(params[:id])

    respond_to do |format|
      if @<%= singular_name %>.update_attributes(params[:<%= singular_name %>])
        flash[:notice] = '<%= model_class_name %> was successfully updated.'
        format.html { redirect_to(<%= plural_name %>_url) }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  # DELETE /<%= plural_name %>/1
  def destroy
    @<%= singular_name %> = <%= model_class_name %>.find(params[:id])
    <%- if options[:with_categories] -%>
    @active_category = @<%= singular_name %>.category
    <%- end -%>
    @<%= singular_name %>.destroy

    respond_to do |format|
      format.html { redirect_to(<%= plural_name %>_url) }
      format.js { index_js }
    end
  end
  
  protected
  
  def index_js
    <%- if options[:with_categories] -%>
    @categories = <%= category_model_class_name %>.find(:all)
    @active_category = @active_category || <%= category_model_class_name %>.find_by_id(params[:category]) || <%= category_model_class_name %>.default
    @documents = @active_category.documents
    <%- end -%>
    render :update do |page|
      page.replace_html :categories_area, :partial => '<%= categories_plural_name %>/category', :collection => @categories
      unless @documents.empty?
        page.replace_html :documents_area, :partial => '<%= plural_name %>/document', :collection => @documents
      else
        page.replace_html :documents_area, 'There are no documents to display.'
      end
      page.replace_html :form_area, :partial => '<%= plural_name %>/upload'
    end
  end
end