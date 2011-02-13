require 'spec_helper'

describe ContactsController do

  before do
    @admin = Factory(:user)
    Factory(:person)
    @product = Factory(:product)
    sign_in @admin
  end

  describe '#create' do
     before do
       post :create, :contact => Factory.attributes_for(:contact, :contactable => @product), :product_id => @product.id
     end

     it "should create a contact" do
       Contact.all.size.should be 1
     end

     it "should have a parent object" do
       Contact.first.contactable_type.should == 'Product'
     end
   end

   describe '#update' do
     before do
       @contact = Factory(:contact)
       put :update, :id => @contact.id, :contact => { :email => "bill@example.com" }
     end

     it "should update a contact" do
       # pending "should specify update action"
       @contact.reload.email.should == "bill@example.com"
     end
   end

   describe '#destroy' do
     before do
       @contact = Factory(:contact)
       @contact_count = Contact.all.size
       delete :destroy, :id => @contact.id
     end

     it "should destroy a contact" do
       # pending "should specify destroy action"
       Contact.all.size.should == @contact_count - 1
       expect{@contact.reload}.to raise_error ActiveRecord::RecordNotFound
     end
   end
end
