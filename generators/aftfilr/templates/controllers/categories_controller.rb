class <%= categories_controller_class_name %> < ApplicationController
  # GET /<%= categories_table_name %>
  def index
    @<%= categories_table_name %> = <%= category_model_class_name %>.find(:all)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /<%= categories_table_name %>/1
  def show
    @<%= category_singular_name %> = <%= category_model_class_name %>.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /<%= categories_table_name %>/new
  def new
    @<%= category_singular_name %> = <%= category_model_class_name %>.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /<%= categories_table_name %>/1/edit
  def edit
    @<%= category_singular_name %> = <%= category_model_class_name %>.find(params[:id])
  end

  # POST /<%= categories_table_name %>
  def create
    @<%= category_singular_name %> = <%= category_model_class_name %>.new(params[:<%= category_singular_name %>])

    respond_to do |format|
      if @<%= category_singular_name %>.save
        flash[:notice] = '<%= category_model_class_name %> was successfully created.'
        format.html { redirect_to(@<%= category_singular_name %>) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /<%= categories_table_name %>/1
  def update
    @<%= category_singular_name %> = <%= category_model_class_name %>.find(params[:id])

    respond_to do |format|
      if @<%= category_singular_name %>.update_attributes(params[:<%= category_singular_name %>])
        flash[:notice] = '<%= category_model_class_name %> was successfully updated.'
        format.html { redirect_to(@<%= category_singular_name %>) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /<%= categories_table_name %>/1
  def destroy
    @<%= category_singular_name %> = <%= category_model_class_name %>.find(params[:id])
    @<%= category_singular_name %>.destroy

    respond_to do |format|
      format.html { redirect_to(<%= categories_table_name %>_url) }
    end
  end
end
