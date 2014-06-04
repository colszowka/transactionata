require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  test_data do
    puts "Loading test data in #{self}"
    15.times do
      FactoryGirl.create(:post)
    end
    FactoryGirl.create(:post, :title => "Foobar")
  end
  
  setup do
    @post = Post.find_by_title!('Foobar')
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_equal 18, assigns(:posts).count # 16 from test_data, 2 from fixtures!
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      post :create, :post => @post.attributes
    end

    assert_redirected_to post_path(assigns(:post))
  end

  test "should show post" do
    get :show, :id => @post.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @post.to_param
    assert_response :success
  end

  test "should update post" do
    put :update, :id => @post.to_param, :post => @post.attributes
    assert_redirected_to post_path(assigns(:post))
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete :destroy, :id => @post.to_param
    end

    assert_redirected_to posts_path
  end
end
