require 'test_helper'

class ContributionsControllerTest < ActionController::TestCase
  
  context "CRD abilities" do  
    
    setup do
      @item = Factory(:product)
      @user = Factory(:user)
      sign_in(@user)
      @request.env['HTTP_REFERER'] = 'http://' + @request.env['HTTP_HOST'] + product_path(@item)            
    end
  
    should "render index template" do
      get :index
      assert_template 'index'
    end
    
    should "redirect when model is valid" do
      Contribution.any_instance.stubs(:valid?).returns(true)
      post :create, :product_id => @item.id, :name => 'product'
      assert_redirected_to @item
    end
    
    should "destroy model and redirect to index action" do
      contribution = @item.contributions.first
      assert_difference "Contribution.count", -1 do
      delete :destroy, :id => Contribution.first, :product_id => @item.id, :name => 'product'
      end
      assert_redirected_to @item
      assert !Contribution.exists?(contribution)
    end

  end
  
end
