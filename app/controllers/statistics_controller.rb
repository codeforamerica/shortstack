class StatisticsController < ApplicationController
  before_filter :authenticate_user!

  helper_method :sort_direction

  # GET /statistics
  # GET /statistics.xml
  def index
    @statistics = Statistic
      .where(:statistic_type_id => params[:statistic_type_id] || 1)
      .where('value != ""')
      .order('CAST(value AS int) ' + sort_direction)
      .paginate(
        :per_page => params[:per_page] || 50,
        :page => params[:page]
      )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @statistics }
    end
  end

  # GET /statistics/1
  # GET /statistics/1.xml
  def show
    @statistic = Statistic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @statistic }
    end
  end

  # GET /statistics/new
  # GET /statistics/new.xml
  def new
    @statistic = Statistic.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @statistic }
    end
  end

  # GET /statistics/1/edit
  def edit
    @statistic = Statistic.find(params[:id])
  end

  # POST /statistics
  # POST /statistics.xml
  def create
    @statisticable = find_statisticable
    @statistic = @statisticable.statistics.build(params[:statistic])

    respond_to do |format|
      if @statistic.save
        format.html { redirect_to(@statisticable, :notice => 'Statistic was successfully created.') }
        format.xml  { render :xml => @statistic, :status => :created, :location => @statistic }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @statistic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /statistics/1
  # PUT /statistics/1.xml
  def update
    @statistic = Statistic.find(params[:id])
    statisticable = @statistic.statisticable

    respond_to do |format|
      if @statistic.update_attributes(params[:statistic])
        format.html { redirect_to(statisticable, :notice => 'Statistic was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @statistic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /statistics/1
  # DELETE /statistics/1.xml
  def destroy
    @statistic = Statistic.find(params[:id])
    statisticable = @statistic.statisticable
    @statistic.destroy

    respond_to do |format|
      format.html { redirect_to(statisticable) }
      format.xml  { head :ok }
    end
  end

  private

  def find_statisticable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        logger.info $1.inspect
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

  def sort_direction
    ['asc', 'desc'].include?(params[:direction]) ? params[:direction] : 'desc'
  end
end
