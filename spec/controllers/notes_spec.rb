#spec/controllers/notes_spec.rb
require 'spec_helper'

describe NotesController do

  before do
    @admin = Factory(:user)
    Factory(:person)
    sign_in @admin
  end

  describe '#create' do
     before do
       puts Person.all.inspect
       post :create, :note => Factory.attributes_for(:note)
     end
     
     it "should create a note" do
       Note.all.size.should be 1
     end
     
     it "should have a parent object" do
       Note.first.noteable_type.should == 'Person'
     end
   end
   
   describe '#update' do
     before do
       @note = Factory(:note)
       put :update, :id => @note.id, :note => { :name => "pizza party at dan's house" }
     end
   
     it "should update a note" do
       # pending "should specify update action"
       @note.reload.name.should == "pizza party at dan's house"
     end
   end
   
   describe '#destroy' do
     before do
       @note = Factory(:note)
       @note_count = Note.all.size
       delete :destroy, :id => @note.id
     end
   
     it "should destroy a note" do
       # pending "should specify destroy action"
       Note.all.size.should == @note_count - 1
       expect{@note.reload}.to raise_error ActiveRecord::RecordNotFound
     end
   end
end
