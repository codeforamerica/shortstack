#spec/controllers/notes_spec.rb
require 'spec_helper'

describe NotesController do

  before do
    @note = Factory(:note)
  end

  describe '#create' do
    before do
      post :index, @note
    end
    
    it "should create a note" do
      # pending "should specify create action"
      assigns[:notes].length.should == 1
      assigns[:notes].should include(@note)
    end
    
    it "should have a parent object" do
      assigns[:notes].first.noteable_id.should be
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
