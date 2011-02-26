class WhiskTypesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_user
  # GET /whisk_types
  # GET /whisk_types.xml
  def index
    @whisk_types = WhiskType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @whisk_types }
    end
  end

  # GET /whisk_types/1
  # GET /whisk_types/1.xml
  def show
    @whisk_type = WhiskType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @whisk_type }
    end
  end

  # GET /whisk_types/new
  # GET /whisk_types/new.xml
  def new
    @whisk_type = WhiskType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @whisk_type }
    end
  end

  # GET /whisk_types/1/edit
  def edit
    @whisk_type = WhiskType.find(params[:id])
  end

  # POST /whisk_types
  # POST /whisk_types.xml
  def create
    @whisk_type = WhiskType.new(params[:whisk_type])

    respond_to do |format|
      if @whisk_type.save
        format.html { redirect_to(whisk_types_path, :notice => 'Note type was successfully created.') }
        format.xml  { render :xml => @whisk_type, :status => :created, :location => @whisk_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @whisk_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /whisk_types/1
  # PUT /whisk_types/1.xml
  def update
    @whisk_type = WhiskType.find(params[:id])

    respond_to do |format|
      if @whisk_type.update_attributes(params[:whisk_type])
        format.html { redirect_to(@whisk_type, :notice => 'Note type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @whisk_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /whisk_types/1
  # DELETE /whisk_types/1.xml
  def destroy
    @whisk_type = WhiskType.find(params[:id])
    @whisk_type.destroy

    respond_to do |format|
      format.html { redirect_to(whisk_types_url) }
      format.xml  { head :ok }
    end
  end
end
