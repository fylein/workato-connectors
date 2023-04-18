# frozen_string_literal: true

RSpec.describe 'triggers/new_expenses', :vcr do

  # Spec describes the most commons blocks of a trigger.
  # Depending on the type of your trigger remove describes that you don't need.
  # Learn more: https://docs.workato.com/developing-connectors/sdk/cli/reference/rspec-commands.html

  subject(:output) { connector.triggers.new_expenses(input) }

  let(:connector) { Workato::Connector::Sdk::Connector.from_file('connector.rb', settings) }
  let(:settings) { Workato::Connector::Sdk::Settings.from_default_file }
  let(:input) { {} }

  pending 'add some examples for trigger output'

  # Or add more fine grained tests for each trigger definition block
  let(:trigger) { connector.triggers.new_expenses }

  describe 'webhook_subscribe' do
    subject(:output) { trigger.webhook_subscribe(webhook_url, settings, input, recipe_id) }

    pending 'add some examples or remove for poll trigger'
  end

  describe 'webhook_unsubscribe' do
    subject(:output) { trigger.webhook_unsubscribe(subscribe_output) }

    pending 'add some examples or remove for poll trigger'
  end

  describe 'webhook_notification' do
    subject(:output) { trigger.webhook_notification(settings, payload, e_i_s, e_o_s, headers, params) }

    pending 'add some examples or remove for poll trigger'
  end

  describe 'poll' do
    subject(:output) { trigger.poll(settings, input, closure) }

    pending 'add some examples or remove for webhook based trigger'
  end

  describe 'dedup' do
    subject(:output) { trigger.dedup(record) }

    pending 'add some examples'
  end

  describe 'sample_output' do
    subject(:sample_output) { trigger.sample_output(settings, input) }

    pending 'add some examples'
  end

  describe 'input_fields' do
    subject(:input_fields) { trigger.input_fields(settings, config_fields) }

    pending 'add some examples'
  end

  describe 'output_fields' do
    subject(:output_fields) { trigger.output_fields(settings, config_fields) }

    pending 'add some examples'
  end
end
