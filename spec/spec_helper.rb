$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'activeavro'

RSpec.configure do |config|
  config.expect_with :rspec do |rspec|
    # Old habits die hard and I use should syntax a lot. Sue me.
    rspec.syntax = [:should, :expect]
  end
end

Dir['./spec/support/**/*.rb'].each { |f| require f }

