class LinksController < ApplicationController
  before_filter :authenticate_user!
  # GET /links
  # GET /links.xml
  def index
    @links = Link.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @links }
    end
  end

  # GET /links/1
  # GET /links/1.xml
  def show
    @link = Link.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @link }
    end
  end

  # GET /links/new
  # GET /links/new.xml
  def new
    @link = Link.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @link }
    end
  end

  # GET /links/1/edit
  def edit
    @link = Link.find(params[:id])
  end

  # POST /links
  # POST /links.xml
  def create
    if !params[:license_key].blank?
     params[:link][:name] = Link.first.licenses[params[:license_key]][0]
     params[:link][:link_url] = Link.first.licenses[params[:license_key]][1]
    end
    @linkable = find_linkable
    @link = @linkable.links.build(params[:link])

    respond_to do |format|
      if @link.save
        format.html { redirect_to(@link.linkable, :notice => 'Link was successfully created.') }
        format.xml  { render :xml => @link, :status => :created, :location => @link }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /links/1
  # PUT /links/1.xml
  def update
    @link = Link.find(params[:id])
    linkable = @link.linkable

    respond_to do |format|
      if @link.update_attributes(params[:link])
        format.html { redirect_to(linkable, :notice => 'Link was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.xml
  def destroy
    @link = Link.find(params[:id])
    linkable = @link.linkable
    @link.destroy

    respond_to do |format|
      format.html { redirect_to(linkable) }
      format.xml  { head :ok }
    end
  end

  private

  def find_linkable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
