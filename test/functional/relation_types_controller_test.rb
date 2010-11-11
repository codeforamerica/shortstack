require 'test_helper'

class RelationTypesControllerTest < ActionController::TestCase
  
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
      RelationType.any_instance.stubs(:valid?).returns(true)
      post :create
      assert_redirected_to relation_types_path
    end
    
    should "render edit template" do
      relation_type = Factory(:relation_type)
      get :edit, :id => relation_type
      assert_template 'edit'
    end
    
    should "destroy model and redirect to index action" do
      relation_type = Factory(:relation_type)
      assert_difference "RelationType.count", -1 do
      delete :destroy, :id => RelationType.first
      end
      assert_redirected_to relation_types_path
      assert !RelationType.exists?(relation_type)
    end

  end
  
end
