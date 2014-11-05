# Return a full path to fixture given by name.
def fixture(name)
  path = Pathname.new(__FILE__).dirname + "../fixtures/#{name}"
  path.realpath
end

require_relative '../fixtures/message'

