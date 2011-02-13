require 'spec_helper'

describe AddressesController do

  before do
    @admin = Factory(:user)
    Factory(:person)
    @product = Factory(:product)
    sign_in @admin
  end

  describe '#create' do
     before do
       post :create, :address => Factory.attributes_for(:address, :addressable => @product), :product_id => @product.id
     end

     it "should create a address" do
       Address.all.size.should be 1
     end

     it "should have a parent object" do
       Address.first.addressable_type.should == 'Product'
     end
   end

   describe '#update' do
     before do
       @address = Factory(:address)
       put :update, :id => @address.id, :address => { :address => "123 Elm Street" }
     end

     it "should update a address" do
       # pending "should specify update action"
       @address.reload.address.should == "123 Elm Street"
     end
   end

   describe '#destroy' do
     before do
       @address = Factory(:address)
       @address_count = Address.all.size
       delete :destroy, :id => @address.id
     end

     it "should destroy a address" do
       # pending "should specify destroy action"
       Address.all.size.should == @address_count - 1
       expect{@address.reload}.to raise_error ActiveRecord::RecordNotFound
     end
   end
end
