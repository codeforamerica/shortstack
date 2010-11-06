class ContributionsController < ApplicationController
  # GET /contributions
  # GET /contributions.xml
  def index
    @contributions = Contribution.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contributions }
    end
  end

  # GET /contributions/1
  # GET /contributions/1.xml
  def show
    @contribution = Contribution.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contribution }
    end
  end

  # GET /contributions/new
  # GET /contributions/new.xml
  def new
    @contribution = Contribution.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contribution }
    end
  end

  # GET /contributions/1/edit
  def edit
    @contribution = Contribution.find(params[:id])
  end

  # POST /contributions
  # POST /contributions.xml
  def create
    @contribution = Contribution.new(params[:contribution])

    respond_to do |format|
      if @contribution.save
        format.html { redirect_to(@contribution, :notice => 'Contribution was successfully created.') }
        format.xml  { render :xml => @contribution, :status => :created, :location => @contribution }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contribution.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contributions/1
  # PUT /contributions/1.xml
  def update
    @contribution = Contribution.find(params[:id])

    respond_to do |format|
      if @contribution.update_attributes(params[:contribution])
        format.html { redirect_to(@contribution, :notice => 'Contribution was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contribution.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contributions/1
  # DELETE /contributions/1.xml
  def destroy
    @contribution = Contribution.find(params[:id])
    @contribution.destroy

    respond_to do |format|
      format.html { redirect_to(contributions_url) }
      format.xml  { head :ok }
    end
  end
end
