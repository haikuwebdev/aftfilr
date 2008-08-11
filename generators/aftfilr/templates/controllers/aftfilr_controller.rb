class <%= controller_class_name %>Controller < ApplicationController
  
  # GET /<%= plural_name %>
  def index
    @<%= plural_name %> = <%= model_class_name %>.find(:all)

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

    respond_to do |format|
      if @<%= singular_name %>.save
        flash[:notice] = '<%= model_class_name %> was successfully created.'
        format.html { redirect_to(<%= plural_name %>_url) }
        format.js {}
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
    @<%= singular_name %>.destroy

    respond_to do |format|
      format.html { redirect_to(<%= plural_name %>_url) }
      format.js {}
    end
  end
  
  protected
  
  def index_js
    @categories = <%= model_class_name %>.find(:all)
    render :update do |page|
      # page.replace_html :categories_area
      page.replace_html :documents_area, :partial => '<%= plural_name %>/document', :collection => @<%= plural_name %>
    end
  end
end