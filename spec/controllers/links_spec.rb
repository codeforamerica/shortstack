require 'spec_helper'

describe LinksController do

  before do
    @admin = Factory(:user)
    Factory(:person)
    @product = Factory(:product)
    sign_in @admin
  end

  describe '#create' do
     before do
       post :create, :link => Factory.attributes_for(:link, :linkable => @product), :product_id => @product.id
     end

     it "should create a link" do
       Link.all.size.should == 1
     end

     it "should have a parent object" do
       Link.first.linkable_type.should == 'Product'
     end
   end

   describe '#update' do
     before do
       @link = Factory(:link)
       put :update, :id => @link.id, :link => { :name => "Example" }
     end

     it "should update a link" do
       # pending "should specify update action"
       @link.reload.name.should == "Example"
     end
   end

   describe '#destroy' do
     before do
       @link = Factory(:link)
       @link_count = Link.all.size
       delete :destroy, :id => @link.id
     end

     it "should destroy a link" do
       # pending "should specify destroy action"
       Link.all.size.should == @link_count - 1
       expect{@link.reload}.to raise_error ActiveRecord::RecordNotFound
     end
   end
end
