class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /profiles
  # GET /profiles.xml
  def index
    # params[:sort_by] => name || this_week || this_month || this_year || all_time
    # @profiles = Profile.joins(:contributions).all
    @profiles = Profile.sort_by(params[:sort_by]).all
    @sort_list = [
      {:id => 'name', :name => 'Name'},
      {:id => 'this_week', :name => 'Contributions This Week'},
      {:id => 'this_month', :name => 'Contributions This Month'},
      {:id => 'this_year', :name => 'Contributions This Year'},
      {:id => 'all_time', :name => 'Contributions All Time'},
    ]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @profiles }
    end
  end

  # GET /profiles/1
  # GET /profiles/1.xml
  def show
    @profile = Profile.find(params[:id])
    @contributions = @profile.contributions.limit(10).order('updated_at DESC')

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @profile }
    end
  end

  # GET /profiles/1/edit
  def edit
    @profile = current_user.profile

  end


  # PUT /profiles/1
  # PUT /profiles/1.xml
  def update
    @profile = current_user.profile

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to(@profile, :notice => 'Profile was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.xml
  def destroy
    @profile = current_user.profile.find(params[:id])
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to(profiles_url) }
      format.xml  { head :ok }
    end
  end
  
end
