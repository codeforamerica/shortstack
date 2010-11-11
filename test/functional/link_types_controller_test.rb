require 'test_helper'

class LinkTypesControllerTest < ActionController::TestCase
  
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
      LinkType.any_instance.stubs(:valid?).returns(true)
      post :create
      assert_redirected_to link_types_path
    end
    
    should "render edit template" do
      link_type = Factory(:link_type)
      get :edit, :id => link_type
      assert_template 'edit'
    end
    
    should "destroy model and redirect to index action" do
      link_type = Factory(:link_type)
      assert_difference "LinkType.count", -1 do
      delete :destroy, :id => LinkType.first
      end
      assert_redirected_to link_types_path
      assert !LinkType.exists?(link_type)
    end

  end
  
end
