require 'test_helper'

class OrgTypesControllerTest < ActionController::TestCase
  
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
      OrgType.any_instance.stubs(:valid?).returns(true)
      post :create
      assert_redirected_to org_types_path
    end
    
    should "render edit template" do
      org_type = Factory(:org_type)
      get :edit, :id => org_type
      assert_template 'edit'
    end
    
    should "destroy model and redirect to index action" do
      org_type = Factory(:org_type)
      assert_difference "OrgType.count", -1 do
      delete :destroy, :id => OrgType.first
      end
      assert_redirected_to org_types_path
      assert !OrgType.exists?(org_type)
    end

  end
  
end
