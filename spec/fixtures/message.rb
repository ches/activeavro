class Message
  include ActiveAvro::Model

  schema fixture('message.avsc')
end

