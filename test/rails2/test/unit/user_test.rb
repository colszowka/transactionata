require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test_data do
    puts "Loading test data in #{self}"
    user = Factory.create(:user, :login => 'testuser')
    
    5.times do
      Factory.create(:post, :user => user)
    end
  end

  should have_many(:posts)

  should "create properly from Factory" do
    assert user = Factory.create(:user)
  end
  
  should "delete all" do
    User.delete_all
    assert_equal 0, User.count
  end
  
  should "have have only the posts that belong to user and 2 from fixtures" do
    assert_equal 7, Post.count
    assert_equal 5, User.find_by_login!('testuser').posts.count
  end
  
  should "have one User present" do
    assert_equal 1, User.count
  end
end
