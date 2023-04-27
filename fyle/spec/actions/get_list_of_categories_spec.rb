# frozen_string_literal: true

RSpec.describe "actions/get_list_of_categories", :vcr do

  # Spec describes the most commons blocks of an action. Remove describes that you don't need.
  # Learn more: https://docs.workato.com/developing-connectors/sdk/cli/reference/rspec-commands.html

  subject(:output) { connector.actions.get_list_of_categories(input) }

  let(:connector) { Workato::Connector::Sdk::Connector.from_file("connector.rb", settings) }
  let(:settings) { Workato::Connector::Sdk::Settings.from_default_file }
  let(:input) { {} }

  pending "add some examples for action output"

  # Or add more fine grained tests for each action definition block
  let(:action) { connector.actions.get_list_of_categories }

  describe "execute" do
    subject(:output) { action.execute(settings) }
    let(:expected_output) { JSON.parse(File.read("fixtures/actions/get_categories/output.json")) }

    context "give valid input" do
      it "gives expected output" do
        expect(output[:data][0].keys).to eq(expected_output.keys)
      end
    end
  end
end
