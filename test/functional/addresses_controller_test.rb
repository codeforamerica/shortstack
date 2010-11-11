require 'test_helper'

class AddressesControllerTest < ActionController::TestCase
  
  context "CRUD abilities" do  
    
    setup do
      @item = Factory(:product)
      @user = Factory(:user)
      sign_in(@user)
    end
  
    should "render index template" do
      get :index
      assert_template 'index'
    end
    
    should "redirect when model is valid" do
      Address.any_instance.stubs(:valid?).returns(true)
      post :create, :product_id => @item.id, :name => 'product'
      assert_redirected_to @item
    end
    
    should "render edit template" do
      address = Factory(:address,:addressable => @item)
      get :edit, :id => address, :product_id => @item.id, :name => 'product'
      assert_template 'edit'
    end
    
    should "destroy model and redirect to index action" do
      address = @item.addresses << Factory(:address)
      assert_difference "Address.count", -1 do
      delete :destroy, :id => Address.first, :product_id => @item.id, :name => 'product'
      end
      assert_redirected_to @item
      assert !Address.exists?(address)
    end

  end
  
end
