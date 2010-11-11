require 'test_helper'

class RelationshipsControllerTest < ActionController::TestCase
  
  context "CRUD abilities" do  
    
    setup do
      @item = Factory(:product)
      @item2 = Factory(:person)      
      @user = Factory(:user)
      @request.env['HTTP_REFERER'] = 'http://' + @request.env['HTTP_HOST'] + product_path(@item)      
      sign_in(@user)
    end
    
    should "redirect when model is valid" do
      Relationship.any_instance.stubs(:valid?).returns(true)
      post :create, :product_id => @item.id, :person_id => @item2.id
      assert_redirected_to(:back)
    end
    
    should "destroy model and redirect to index action" do
      relationship = @item.relationships << Factory(:relationship)
      assert_difference "Relationship.count", -1 do
      delete :destroy, :id => Relationship.first, :product_id => @item.id, :name => 'product'
      end
      assert_redirected_to(:back)
      assert !Relationship.exists?(relationship)
    end

  end
  
end
