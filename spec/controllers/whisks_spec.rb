require 'spec_helper'

describe WhisksController do

  before do
    @admin = Factory(:user)
    @product = Factory(:product)
    sign_in @admin
  end

  describe '#create' do
     before do
       post :create, :whisk => Factory.attributes_for(:whisk, :whiskable => @product), :product_id => @product.id
     end
     
     it "should create a whisk" do
       Whisk.all.size.should == 1
     end
     
     it "should have a parent object" do
       puts Whisk.first.inspect
       Whisk.first.whiskable_type.should == 'Product'
     end
   end
   
   describe '#update' do
     before do
       @whisk = Factory(:whisk)
       put :update, :id => @whisk.id, :whisk => { :setting => "pizza party at dan's house" }
     end
   
     it "should update a whisk" do
       # pending "should specify update action"
       @whisk.reload.setting.should == "pizza party at dan's house"
     end
   end
   
   describe '#destroy' do
     before do
       @whisk = Factory(:whisk)
       @whisk_count = Whisk.all.size
       delete :destroy, :id => @whisk.id
     end
   
     it "should destroy a whisk" do
       # pending "should specify destroy action"
       Whisk.all.size.should == @whisk_count - 1
       expect{@whisk.reload}.to raise_error ActiveRecord::RecordNotFound
     end
   end
end
