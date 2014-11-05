require 'open-uri'

require 'avro'
require 'axiom-types'
require 'virtus'

module ActiveAvro
  module Model
    # Maps the Avro specification's primitive types to Ruby/Virtus types.
    #
    # @see http://avro.apache.org/docs/current/spec.html#schema_primitive
    AVRO_TYPE_MAP = {
      :boolean => Axiom::Types::Boolean,  # See Virtus README caveat about Boolean
      :int     => Fixnum,
      :long    => Fixnum,
      :float   => BigDecimal,
      :double  => BigDecimal,
      :string  => String,
      :null    => NilClass
    }

    def self.included(base)
      base.send :include, Virtus.model  # TODO: allow options
      base.extend ClassMethods

      base.class_eval do
        # The Avro::Schema that defines de/serialization of this object.
        def avro_schema
          self.class.avro_schema
        end
      end
    end

    module ClassMethods
      # The Avro::Schema that defines de/serialization of model instances.
      attr_reader :avro_schema

      # Declare the Avro schema for records represented by this model class.
      # Object instances are (de)serialized from/to records with this schema,
      # and attributes will be defined for the field names and types specified
      # therein.
      #
      # @param schema [Avro::Schema, String, Pathname, File]
      #   The Avro schema for object (de)serialization. An Avro::Schema instance
      #   will be used directly, or if a String is given it is assumed to be a
      #   file path or URI and opened with OpenURI::OpenRead#open (this means
      #   some additional File-like objects and Pathname are also supported).
      def schema(schema)
        @avro_schema ||= case schema
                         when Avro::Schema
                           schema
                         when String, Pathname, File
                           Avro::Schema.parse(open(schema).read)
                         # when Symbol
                           # look for #{schema}.avsc in a configured path?
                         else raise ArgumentError,
                           "Unsupported type for Avro schema <#{schema.class}>"
                         end

        # Declare a (Virtus) attribute for each field.
        #
        # TODO: this is a quick and dirty start--we'll want to handle default
        # values and other features, like complex types, as best we can.
        @avro_schema.fields.each do |field|
          type = AVRO_TYPE_MAP[field.type.type_sym]
          attribute field.name, type, default: field.default
        end
      end
    end

  end
end

