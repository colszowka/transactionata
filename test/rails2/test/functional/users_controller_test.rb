require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test_data do
    puts "Loading test data in #{self}"    
    Factory.create(:user, :login => 'colszowka')
    8.times do
      Factory.create(:user)
    end
  end
  
  def setup
    @user = User.find_by_login!('colszowka')
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_equal 9, assigns(:users).count
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => { }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, :id => @user.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @user.to_param
    assert_response :success
  end

  test "should update user" do
    put :update, :id => @user.to_param, :user => { }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, :id => @user.to_param
    end

    assert_redirected_to users_path
  end
end
