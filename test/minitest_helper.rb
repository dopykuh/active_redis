$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'active_redis'

require 'minitest/autorun'

Dir['test/test_*.rb'].each do |f|
  require "./#{f}"
end
