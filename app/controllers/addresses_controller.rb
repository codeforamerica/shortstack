class AddressesController < ApplicationController
    before_filter :authenticate_user!  
  # GET /address
  # GET /address.xml
  def index
    @addresses = Address.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @address }
    end
  end

  # GET /address/1
  # GET /address/1.xml
  def show
    @address = Address.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @address }
    end
  end

  # GET /address/new
  # GET /address/new.xml
  def new
    @address = Address.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @address }
    end
  end

  # GET /address/1/edit
  def edit
    @address = Address.find(params[:id])
  end

  # POST /address
  # POST /address.xml
  def create
    @addressable = find_addressable
    @address = @addressable.addresses.build(params[:address])

    respond_to do |format|
      if @address.save
        format.html { redirect_to(@addressable, :notice => 'Address was successfully created.') }
        format.xml  { render :xml => @address, :status => :created, :location => @address }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @address.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /address/1
  # PUT /address/1.xml
  def update
    @address = Address.find(params[:id])

    respond_to do |format|
      if @address.update_attributes(params[:address])
        format.html { redirect_to(@address.addressable, :notice => 'Address was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @address.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /address/1
  # DELETE /address/1.xml
  def destroy
    @address = Address.find(params[:id])
    addressable = @address.addressable
    @address.destroy

    respond_to do |format|
      format.html { redirect_to(addressable, :notice => 'Address was successfully destroyed.') }
      format.xml  { head :ok }
    end
  end
  
  private

  def find_addressable
    type = params[:address][:addressable_type]
    id = params[:address][:addressable_id]
    type.classify.constantize.find(id)
  end
  
end
