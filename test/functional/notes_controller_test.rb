require 'test_helper'

class NotesControllerTest < ActionController::TestCase
  
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
      Note.any_instance.stubs(:valid?).returns(true)
      post :create, :product_id => @item.id, :name => 'product'
      assert_redirected_to @item
    end
    
    should "render show template" do
      note = Factory(:note,:noteable => @item)      
      get :show, :id => note
      assert_template 'show'
    end
    
    should "render edit template" do
      note = Factory(:note,:noteable => @item)
      get :edit, :id => note, :product_id => @item.id, :name => 'product'
      assert_template 'edit'
    end
    
    should "destroy model and redirect to index action" do
      note = @item.notes << Factory(:note)
      assert_difference "Note.count", -1 do
      delete :destroy, :id => Note.first, :product_id => @item.id, :name => 'product'
      end
      assert_redirected_to @item
      assert !Note.exists?(note)
    end

  end
  
end
