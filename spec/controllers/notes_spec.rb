#spec/controllers/notes_spec.rb
require 'spec_helper'

describe NotesController do

  before do
    @admin = Factory(:user)
    sign_in @admin
  end

  describe '#create' do
     before do
       post :index, Factory.attributes_for(:note)
     end
     
     it "should create a note" do
        Note.all.size.should be 1
      end
      
      it "should have a parent object" do
        Note.first.noteable_type.should be 'Person'
      end
   end
   
   describe '#update' do
     before do
       put :update, :id => @note.id, :name => "pizza party at dan's house"
     end
   
     it "should update a note" do
       # pending "should specify update action"
       @note.reload.name.should == "pizza party at dan's house"
     end
   end
   
   describe '#destroy' do
     before do
       delete :destroy, :id => @note.id
     end
   
     it "should destroy a note" do
       # pending "should specify destroy action"
       @note.reload.should be_nil
     end
   end
end
