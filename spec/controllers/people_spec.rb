require 'spec_helper'

describe PeopleController do

  before do
    @admin = Factory(:user)
    sign_in @admin
  end

  describe '#create' do
     before do
       post :create, :person => FactoryGirl.attributes_for(:person)
       @person = Person.find(:first)
       @response = response
     end

     it "should create a person" do
       Person.all.size.should == 1
     end

     it "should redirect to that person" do
       @response.should redirect_to(@person)
     end
   end

   describe '#update' do
     before do
       @person = Factory(:person)
       put :update, :id => @person.id, :person => { :name => "Example" }
       @response = response
     end

     it "should update a person" do
       # pending "should specify update action"
       @person.reload.name.should == "Example"
     end

     it "should redirect to that person" do
       @response.should redirect_to(@person)
     end
   end

   describe '#destroy' do
     before do
       @person = Factory(:person)
       @person_count = Person.all.size
       delete :destroy, :id => @person.id
       @response = response
     end

     it "should destroy a person" do
       # pending "should specify destroy action"
       Person.all.size.should == @person_count - 1
       expect{@person.reload}.to raise_error ActiveRecord::RecordNotFound
     end

     it "should redirect to that people_url" do
       @response.should redirect_to(people_url)
     end
   end
end
