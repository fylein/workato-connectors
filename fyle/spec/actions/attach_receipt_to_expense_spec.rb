# frozen_string_literal: true

RSpec.describe "actions/attach_receipt_to_expense", :vcr do

  # Spec describes the most commons blocks of an action. Remove describes that you don't need.
  # Learn more: https://docs.workato.com/developing-connectors/sdk/cli/reference/rspec-commands.html

  subject(:output) { connector.actions.attach_receipt_to_expense(input) }

  let(:connector) { Workato::Connector::Sdk::Connector.from_file("connector.rb", settings) }
  let(:settings) { Workato::Connector::Sdk::Settings.from_default_file }
  let(:input) { {} }

  # Or add more fine grained tests for each action definition block
  let(:action) { connector.actions.attach_receipt_to_expense }
end
