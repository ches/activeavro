ActiveAvro
==========

[Avro] is a serialization system for data interchange, in the vein of Thrift and
Protocol Buffers, with support for RPC protocol specifications. Unlike these
alternatives, it was designed with friendliness to dynamic languages in mind,
but has received only low-level treatment in Ruby to-date, through [the
implementation maintained in the official Apache repository][avro-ruby].

ActiveAvro aims to extend the baseline Ruby support with:

  - Deserialization into rich Ruby objects using [Virtus].
  - Convenience wrapper APIs for writing/reading Avro data files.
  - Possibly: an optional mixin for ActiveModel conformance, binding lifecycle
    methods of objects to RPC calls with configurable transport.

[Avro]: http://avro.apache.org/
[avro-ruby]: https://github.com/apache/avro/tree/trunk/lang/ruby
[Virtus]: https://github.com/solnic/virtus


Project Status
--------------

This is new project with only basic features implemented, not recommended for
real-world use yet. In particular, only simple Avro schemas are supported (no
complex types), and no ActiveModel or RPC functionality is implemented.
Contributions are welcome :-)


Installation
------------

Add this line to your application's Gemfile:

    gem 'activeavro'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activeavro


Usage
-----

Given a schema definition saved in a file:

    { "type": "record",
      "name": "Message",
      "fields" : [
        { "name": "to", "type": "string" },
        { "name": "from", "type": "string" },
        { "name": "body", "type": "string" },
        { "name": "sent", "type": "boolean", "default": "false" }
      ]
    }

Include the model module and configure the schema, then make use of rich
attribute features with schema fields:

```ruby
class Message
  include ActiveAvro::Model
  schema 'schemata/message.avsc'
end

message = Message.new(to: 'you', from: 'me')
message.from  # => 'me'
message.sent  # => false, from the default
message.body = "This is an important memo."
```

You may specify the schema as a value that can be opened by `open-uri` (File or
Pathname, String, URI, etc.) or an `Avro::Schema` object.


TODO
----

- Buffered read support for large files with lots of Avro records?
- Virtus integration:
  - Embedded values for complex types (user-defined attribute types)
  - Collection member coercions
  - Allow customizing privacy of attribute writers/readers?
- Avro ActiveModel serializer
- Provide an RPC mock?


Acknowledgements
----------------

- Jeff Hodges and the other contributors to the baseline Avro Ruby
  implementation that we build on.


Contributing
------------

1. Fork it.
2. Create your feature branch (`git checkout -b my-new-feature`).
3. Commit your changes (`git commit -am 'Add some feature'`).
4. Push to the branch (`git push origin my-new-feature`).
5. Create new Pull Request.

