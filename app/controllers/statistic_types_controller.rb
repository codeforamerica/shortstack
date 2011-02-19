class StatisticTypesController < ApplicationController
  before_filter :authenticate_user!
  # GET /statistic_types
  # GET /statistic_types.xml
  def index
    @statistic_types = StatisticType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @statistic_types }
    end
  end

  # GET /statistic_types/new
  # GET /statistic_types/new.xml
  def new
    @statistic_type = StatisticType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @statistic_type }
    end
  end

  # GET /statistic_types/1/edit
  def edit
    @statistic_type = StatisticType.find(params[:id])
  end

  # POST /statistic_types
  # POST /statistic_types.xml
  def create
    @statistic_type = StatisticType.new(params[:statistic_type])

    respond_to do |format|
      if @statistic_type.save
        format.html { redirect_to(statistic_types_path, :notice => 'Statistic type was successfully created.') }
        format.xml  { render :xml => @statistic_type, :status => :created, :location => @statistic_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @statistic_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /statistic_types/1
  # PUT /statistic_types/1.xml
  def update
    @statistic_type = StatisticType.find(params[:id])

    respond_to do |format|
      if @statistic_type.update_attributes(params[:statistic_type])
        format.html { redirect_to(statistic_types_path, :notice => 'Statistic type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @statistic_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /statistic_types/1
  # DELETE /statistic_types/1.xml
  def destroy
    @statistic_type = StatisticType.find(params[:id])
    @statistic_type.destroy

    respond_to do |format|
      format.html { redirect_to(statistic_types_url) }
      format.xml  { head :ok }
    end
  end
end
