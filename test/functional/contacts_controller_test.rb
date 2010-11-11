require 'test_helper'

class ContactsControllerTest < ActionController::TestCase
  
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
      Contact.any_instance.stubs(:valid?).returns(true)
      post :create, :product_id => @item.id, :name => 'product'
      assert_redirected_to @item
    end
    
    should "render edit template" do
      contact = Factory(:contact,:contactable => @item)
      get :edit, :id => contact, :product_id => @item.id, :name => 'product'
      assert_template 'edit'
    end
    
    should "destroy model and redirect to index action" do
      contact = @item.contacts << Factory(:contact)
      assert_difference "Contact.count", -1 do
      delete :destroy, :id => Contact.first, :product_id => @item.id, :name => 'product'
      end
      assert_redirected_to @item
      assert !Contact.exists?(contact)
    end

  end
  
end
