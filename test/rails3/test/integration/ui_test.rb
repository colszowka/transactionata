require 'test_helper'

class UiTest < ActionDispatch::IntegrationTest
  fixtures :all
  
  test_data do
    puts "Loading test data in #{self}"
    user = FactoryGirl.create(:user, :login => 'testuser')
    
    5.times do
      FactoryGirl.create(:post, :user => user)
    end
  end

  test "GET /users" do
    get "/users"
    assert_response :success
    assert_equal 1, assigns(:users).count
  end
  
  test "GET /posts" do
    get '/posts'
    assert_response :success
    assert_equal 7, assigns(:posts).count # 5 for user, 2 from fixtures
  end
end
