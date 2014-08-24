require 'aruba/api'
require 'aruba/reporting'

RSpec.configure do |c|
  c.include Aruba::Api
  c.after(:each) do
    restore_env
  end
end

