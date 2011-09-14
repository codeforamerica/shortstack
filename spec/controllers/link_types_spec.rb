require 'spec_helper'

describe LinkTypesController do

  before do
    @admin = Factory(:user)
    Factory(:person)
    sign_in @admin
  end

  describe '#create' do
     before do
       post :create, :link_type => FactoryGirl.attributes_for(:link_type)
     end

     it "should create a link_type" do
       LinkType.all.size.should == 1
     end
   end

   describe '#update' do
     before do
       @link_type = Factory(:link_type)
       put :update, :id => @link_type.id, :link_type => { :name => "Example" }
     end

     it "should update a link_type" do
       # pending "should specify update action"
       @link_type.reload.name.should == "Example"
     end
   end

   describe '#destroy' do
     before do
       @link_type = Factory(:link_type)
       @link_type_count = LinkType.all.size
       delete :destroy, :id => @link_type.id
     end

     it "should destroy a link_type" do
       # pending "should specify destroy action"
       LinkType.all.size.should == @link_type_count - 1
       expect{@link_type.reload}.to raise_error ActiveRecord::RecordNotFound
     end
   end
end
