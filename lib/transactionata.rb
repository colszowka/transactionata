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
  #     
  #     # or for Machinist
  #     @person =  Person.make
  #   end
  #
  # The foobar and @person record will be available in all your tests and rolls back 
  # even if you modify it in your test cases thanks to transactions.
  #
  def test_data(&blk)
    self.class_eval do
      class << self
        attr_accessor :test_data_block
      end
      setup :load_test_data_vars
      
      alias_method :original_load_fixtures, :load_fixtures
      if defined?(ActiveRecord::FixtureSet) # Rails 4.1 or better
        def load_fixtures(config)
          # We need to return the value of the original load_fixtures method, so that all the fixtures magic works
          hash = original_load_fixtures(config)
          existing_klass_instance_vars = self.class.instance_variables
          self.class.test_data_block.call
          @@test_data_vars = (self.class.instance_variables - existing_klass_instance_vars)

          ActiveRecord::FixtureSet.reset_cache
          hash
        end

      else
        def load_fixtures
          # We need to return the value of the original load_fixtures method, so that all the fixtures magic works
          hash = original_load_fixtures
          existing_klass_instance_vars = self.class.instance_variables
          self.class.test_data_block.call
          @@test_data_vars = (self.class.instance_variables - existing_klass_instance_vars)

          if defined?(ActiveRecord::Fixtures) # Rails 3.1
            ActiveRecord::Fixtures.reset_cache
          else
            Fixtures.reset_cache # Required to enforce purging tables for every test file
          end
          hash
        end
      end

      def load_test_data_vars
        @@test_data_vars.each do |new_ivar| # Added block
          self.instance_variable_set(new_ivar, self.class.instance_variable_get(new_ivar))
        end
      end
      
    end
    self.test_data_block = blk
  end
end

if defined?(ActiveSupport::TestCase)
  ActiveSupport::TestCase.send :extend, Transactionata
end