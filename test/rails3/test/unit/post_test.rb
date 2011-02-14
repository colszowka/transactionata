require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test_data do
    puts "Loading test data in #{self}"
    10.times do 
      Factory.create(:post)
    end
    Factory.create(:post, :title => "Foobar")
  end

  should belong_to(:user)
  
  # 11 from test data, 2 from fixtures
  should "have 13 Posts existing" do
    assert_equal 13, Post.count
  end
  
  should "delete 5 posts" do
    5.times { assert Post.last.delete }
  end
  
  should "destroy 5 posts" do
    5.times { assert Post.last.delete }
  end
  
  should "have post with title 'Foobar'" do
    assert Post.find_by_title('Foobar')
  end
  
  should "have no post with title 'Whatever'" do
    assert !Post.find_by_title('Whatever')
  end
  
  
  context "after destroying 3 posts" do
    setup { 3.times { Post.last.destroy } }
    should "have 10 Posts remaining" do
      assert_equal 10, Post.count
    end
  end
end
