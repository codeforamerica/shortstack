class NoteTypesController < ApplicationController
  before_filter :authenticate_user!  
  # GET /note_types
  # GET /note_types.xml
  def index
    @note_types = NoteType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @note_types }
    end
  end

  # GET /note_types/1
  # GET /note_types/1.xml
  def show
    @note_type = NoteType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @note_type }
    end
  end

  # GET /note_types/new
  # GET /note_types/new.xml
  def new
    @note_type = NoteType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @note_type }
    end
  end

  # GET /note_types/1/edit
  def edit
    @note_type = NoteType.find(params[:id])
  end

  # POST /note_types
  # POST /note_types.xml
  def create
    @note_type = NoteType.new(params[:note_type])

    respond_to do |format|
      if @note_type.save
        format.html { redirect_to(note_types_path, :notice => 'Note type was successfully created.') }
        format.xml  { render :xml => @note_type, :status => :created, :location => @note_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @note_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /note_types/1
  # PUT /note_types/1.xml
  def update
    @note_type = NoteType.find(params[:id])

    respond_to do |format|
      if @note_type.update_attributes(params[:note_type])
        format.html { redirect_to(@note_type, :notice => 'Note type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @note_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /note_types/1
  # DELETE /note_types/1.xml
  def destroy
    @note_type = NoteType.find(params[:id])
    @note_type.destroy

    respond_to do |format|
      format.html { redirect_to(note_types_url) }
      format.xml  { head :ok }
    end
  end
end
