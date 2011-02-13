require 'spec_helper'

describe NoteTypesController do

  before do
    @admin = Factory(:user)
    Factory(:person)
    sign_in @admin
  end

  describe '#create' do
     before do
       post :create, :note_type => Factory.attributes_for(:note_type)
     end

     it "should create a note_type" do
       NoteType.all.size.should == 1
     end
   end

   describe '#update' do
     before do
       @note_type = Factory(:note_type)
       put :update, :id => @note_type.id, :note_type => { :name => "Example" }
     end

     it "should update a note_type" do
       # pending "should specify update action"
       @note_type.reload.name.should == "Example"
     end
   end

   describe '#destroy' do
     before do
       @note_type = Factory(:note_type)
       @note_type_count = NoteType.all.size
       delete :destroy, :id => @note_type.id
     end

     it "should destroy a note_type" do
       # pending "should specify destroy action"
       NoteType.all.size.should == @note_type_count - 1
       expect{@note_type.reload}.to raise_error ActiveRecord::RecordNotFound
     end
   end
end
