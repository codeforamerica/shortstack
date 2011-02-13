class ContributionsController < ApplicationController
  before_filter :authenticate_user!
  # GET /contributions
  # GET /contributions.xml
  def index
    @contributions = Contribution.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contributions }
    end
  end

  # POST /contributions
  # POST /contributions.xml
  def create
    @contribution = Contribution.new(params[:contribution])

    respond_to do |format|
      if @contribution.save
        format.html { redirect_to(:back, :notice => 'Contribution was successfully created.') }
        format.xml  { render :xml => @contribution, :status => :created, :location => @contribution }
      else
        format.html { render :action => "new" }
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
      format.html { redirect_to(:back) }
      format.xml  { head :ok }
    end
  end
end
