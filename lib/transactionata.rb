module Transactionata
  #
  # Hook for creating test data ONCE alongside fixtures that will then be rolled back
  # via transactions after each test, so you can set up complex data via Factories etc.
  # without the speed drop.
  #
  # Please note that you'll have to set up empty fixture files (and load them, see
  # the list of fixtures above) in order to clean up the database before you launch 
  # your tests.
  #
  # Usage: In your test class, do:
  #   test_data do
  #     Factory.create(:foobar)
  #     # etc...
  #   end
  #
  # The foobar record will be available in all your tests and rolls back even if you
  # modify it in your test cases thanks to transactions.
  #
  def test_data(&blk)
    self.class_eval do
      class << self
        attr_accessor :test_data_block
      end
      
      alias_method :original_load_fixtures, :load_fixtures
      def load_fixtures
        original_load_fixtures
        self.class.test_data_block.call
        
        if defined?(ActiveRecord::FixtureSet) # Rails 3.1
          ActiveRecord::FixtureSet.reset_cache
        else
          Fixtures.reset_cache # Required to enforce purging tables for every test file
        end
      end
    end
    self.test_data_block = blk
  end
end

if defined?(ActiveSupport::TestCase)
  ActiveSupport::TestCase.send :extend, Transactionata
end
