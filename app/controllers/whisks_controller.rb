class WhisksController < ApplicationController
  before_filter :authenticate_user!  
  # GET /whisks
  # GET /whisks.xml
  def index
    @whisks = Whisk.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @whisks }
    end
  end

  # GET /whisks/1
  # GET /whisks/1.xml
  def show
    @whisk = Whisk.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @whisk }
    end
  end

  # GET /whisks/new
  # GET /whisks/new.xml
  def new
    @whisk = Whisk.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @whisk }
    end
  end

  # GET /whisks/1/edit
  def edit
    @whisk = Whisk.find(params[:id])
  end

  # POST /whisks
  # POST /whisks.xml
  def create
    @whiskable = find_whiskable
    @whisk = @whiskable.whisks.build(params[:whisk])

    respond_to do |format|
      if @whisk.save
        format.html { redirect_to(@whiskable, :notice => 'Whisk was successfully created.') }
        format.xml  { render :xml => @whisk, :status => :created, :location => @whisk }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @whisk.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /whisks/1
  # PUT /whisks/1.xml
  def update
    @whisk = Whisk.find(params[:id])

    respond_to do |format|
      if @whisk.update_attributes(params[:whisk])
        format.html { redirect_to(@whisk, :notice => 'Whisk was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @whisk.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /whisks/1
  # DELETE /whisks/1.xml
  def destroy
    @whisk = Whisk.find(params[:id])
    whiskable = @whisk.whiskable
    @whisk.destroy

    respond_to do |format|
      format.html { redirect_to(whiskable) }
      format.xml  { head :ok }
    end
  end
  
  private

  def find_whiskable
    
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
  
end
