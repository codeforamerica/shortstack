require 'test_helper'

class LinksControllerTest < ActionController::TestCase
  
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
      Link.any_instance.stubs(:valid?).returns(true)
      post :create, :product_id => @item.id, :name => 'product'
      assert_redirected_to @item
    end
    
    should "render show template" do
      link = Factory(:link,:linkable => @item)      
      get :show, :id => link
      assert_template 'show'
    end
    
    should "render edit template" do
      link = Factory(:link,:linkable => @item)
      get :edit, :id => link, :product_id => @item.id, :name => 'product'
      assert_template 'edit'
    end
    
    should "destroy model and redirect to index action" do
      link = @item.links << Factory(:link)
      assert_difference "Link.count", -1 do
      delete :destroy, :id => Link.first, :product_id => @item.id, :name => 'product'
      end
      assert_redirected_to @item
      assert !Link.exists?(link)
    end

  end
  
end
