class ProductsController < ApplicationController
  before_filter :authenticate_user!  
  # GET /products
  # GET /products.xml
  def index
    @products = Product.alpha.paginate(:per_page => 99, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])
    @has_whisks = !@product.whisks.blank?

    crunch_lt = LinkType.where(:name => 'crunchbase').first
    @has_crunchies = !@product.links.where(:link_type_id => crunch_lt.id).blank?

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.xml
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to(@product, :notice => 'Product was successfully created.') }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to(@product, :notice => 'Product was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to(products_url) }
      format.xml  { head :ok }
    end
  end
  
  def whiskme
    @product = Product.find(params[:id])
    @product.send_later(:whisk_cities)
    redirect_to(@product, :notice => 'Whisking some batter. Lots of pancakes. So, come back later to eat.')
  end

  def crunchsync
    @product = Product.find(params[:id])
    logger.info "delaying crunch_sync"
    @product.send_later(:crunch_sync)
    redirect_to(@product, :notice => 'Syncing with Crunchbase.')
  end
end
