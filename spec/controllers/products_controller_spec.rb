require 'spec_helper'

describe ProductsController do
  before do
    @product = Factory(:product)
    @company = Factory(:company)
    @company.products << @product
    @admin = Factory(:user)
    sign_in @admin
  end

  it 'should return xml pad specification' do
    get :show, :id => @product.id, :format => :xml
    response.should be_success
  end

  it 'should return json pad specification' do
    get :show, :id => @product.id, :format => :json
    response.should be_success
    puts JSON.parse(response.body).inspect
  end
end
