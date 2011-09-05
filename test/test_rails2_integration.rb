require 'helper'

class TestRails2Integration < Test::Unit::TestCase
  def setup
    ENV['BUNDLE_GEMFILE'] = nil # Bundler confuses the rake test task...
    @original_wd = Dir.getwd
    Dir.chdir(File.join(File.dirname(__FILE__), 'rails2'))
  end
  
  def teardown
    Dir.chdir @original_wd
  end
  
  def test_passing_rails2_test_suite
    test_suite_output = `rake test`
    exit_status = $?

    assert exit_status.success?, "Rails 2 app's test suite should pass! Output was: #{test_suite_output}"
    
    assert_equal 1, test_suite_output.scan(/Loading test data in PostTest/).length
    assert_equal 1, test_suite_output.scan(/Loading test data in PostsControllerTest/).length
    assert_equal 1, test_suite_output.scan(/Loading test data in UserTest/).length
    assert_equal 1, test_suite_output.scan(/Loading test data in UsersControllerTest/).length
    assert_equal 1, test_suite_output.scan(/Loading test data in UiTest/).length
  end
end