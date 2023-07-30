RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test #rack_test, which is provided by Capybara
  end
end
# This tells RSpec how to run end-to-end system tests
