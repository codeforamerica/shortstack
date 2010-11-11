require 'test_helper'

class NoteTypesControllerTest < ActionController::TestCase
  
  context "CRUD abilities" do  
    
    setup do
      @user = Factory(:user)
      sign_in(@user)
    end
  
    should "render index template" do
      get :index
      assert_template 'index'
    end
    
    should "redirect when model is valid" do
      NoteType.any_instance.stubs(:valid?).returns(true)
      post :create
      assert_redirected_to note_types_path
    end
    
    should "render edit template" do
      note_type = Factory(:note_type)
      get :edit, :id => note_type
      assert_template 'edit'
    end
    
    should "destroy model and redirect to index action" do
      note_type = Factory(:note_type)
      assert_difference "NoteType.count", -1 do
      delete :destroy, :id => NoteType.first
      end
      assert_redirected_to note_types_path
      assert !NoteType.exists?(note_type)
    end

  end
  
end
