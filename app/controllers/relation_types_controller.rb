class RelationTypesController < ApplicationController
  before_filter :authenticate_user!
  # GET /relation_types
  # GET /relation_types.xml
  def index
    @relation_types = RelationType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @relation_types }
    end
  end

  # GET /relation_types/1
  # GET /relation_types/1.xml
  def show
    @relation_type = RelationType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @relation_type }
    end
  end

  # GET /relation_types/new
  # GET /relation_types/new.xml
  def new
    @relation_type = RelationType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @relation_type }
    end
  end

  # GET /relation_types/1/edit
  def edit
    @relation_type = RelationType.find(params[:id])
  end

  # POST /relation_types
  # POST /relation_types.xml
  def create
    @relation_type = RelationType.new(params[:relation_type])

    respond_to do |format|
      if @relation_type.save
        format.html { redirect_to(relation_types_path, :notice => 'Relation type was successfully created.') }
        format.xml  { render :xml => @relation_type, :status => :created, :location => @relation_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @relation_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /relation_types/1
  # PUT /relation_types/1.xml
  def update
    @relation_type = RelationType.find(params[:id])

    respond_to do |format|
      if @relation_type.update_attributes(params[:relation_type])
        format.html { redirect_to(relation_types_path, :notice => 'Relation type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @relation_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /relation_types/1
  # DELETE /relation_types/1.xml
  def destroy
    @relation_type = RelationType.find(params[:id])
    @relation_type.destroy

    respond_to do |format|
      format.html { redirect_to(relation_types_url) }
      format.xml  { head :ok }
    end
  end
end
