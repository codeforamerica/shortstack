class RelationshipsController < ApplicationController
  
  # GET /relationships
  # GET /relationships.xml
  def index
    @relationships = Relationship.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @relationships }
    end
  end

  # GET /relationships/1
  # GET /relationships/1.xml
  def show
    @relationship = Relationship.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @relationship }
    end
  end

  # GET /relationships/1/edit
  def edit
    @relationship = current_user.profile
  end
  
  
  # POST /relationship
  # POST /relationship.xml
  def create
    @relationship = Relationship.new(params[:relationship])
    if params[:product_id]
      @relationship.product = Product.find(params[:product_id])
    end
    if params[:organization_id]
      @relationship.organization = Organization.find(params[:organization_id])
    end
    if params[:person_id]
      @relationship.person = Person.find(params[:person_id])
    end

    respond_to do |format|
      if @relationship.save
        format.html { redirect_to(:back, :notice => 'Relationship was successfully created.') }
        format.xml  { render :xml => @relationship, :status => :created, :location => @relationship }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @relationship.errors, :status => :unprocessable_entity }
      end
    end
  end


  # PUT /relationships/1
  # PUT /relationships/1.xml
  def update
    @relationship = Relationship.find(params[:id])

    respond_to do |format|
      if @relationship.update_attributes(params[:relationship])
        format.html { redirect_to(@relationship, :notice => 'Relationship was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @relationship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /relationships/1
  # DELETE /relationships/1.xml
  def destroy
    @relationship = Relationship.find(params[:id])
    @relationship.destroy

    respond_to do |format|
      format.html { redirect_to(:back) }
      format.xml  { head :ok }
    end
  end
end
