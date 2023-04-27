# frozen_string_literal: true

RSpec.describe 'object_definition/system_category', :vcr do

  # Spec describes the most commons blocks of an object definition.
  # Learn more: https://docs.workato.com/developing-connectors/sdk/cli/reference/rspec-commands.html

  let(:connector) { Workato::Connector::Sdk::Connector.from_file('connector.rb', settings) }
  let(:settings) { Workato::Connector::Sdk::Settings.from_default_file }

  let(:object_definition) { connector.object_definitions.system_category }

  describe 'fields' do
    subject(:schema_fields) { object_definition.fields(settings, config_fields) }

    pending 'add some examples'
  end
end
