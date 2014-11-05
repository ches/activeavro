require 'active_avro/version'

module ActiveAvro
  class Error < StandardError; end

  autoload :Model, 'active_avro/model'
end

