require 'spec_helper'

describe ActiveAvro::Model do
  let(:message) { Message.new(to: 'martin', from: 'gina') }

  it 'creates object attributes from parsed Avro schema' do
    message.to.should eq 'martin'
    message.body.should be_nil
  end

  it 'sets field default values from Avro schema' do
    message.sent.should be false
  end

  # TODO: Why is this not being defined?
  pending 'defines predicate methods for Boolean fields' do
    expect { message.sent? }.not_to raise_error
  end
end

