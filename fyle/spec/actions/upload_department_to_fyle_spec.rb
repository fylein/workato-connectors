# frozen_string_literal: true

RSpec.describe "actions/upload_department_to_fyle", :vcr do

  # Spec describes the most commons blocks of an action. Remove describes that you don't need.
  # Learn more: https://docs.workato.com/developing-connectors/sdk/cli/reference/rspec-commands.html

  subject(:output) { connector.actions.upload_department_to_fyle(input) }

  let(:connector) { Workato::Connector::Sdk::Connector.from_file("connector.rb", settings) }
  let(:settings) { Workato::Connector::Sdk::Settings.from_default_file }
  let(:input) { {} }

  # Or add more fine grained tests for each action definition block
  let(:action) { connector.actions.upload_department_to_fyle }

  describe "input_fields" do
    subject(:output_fields) { action.input_fields(settings) }
    let(:expected_input_fields) { JSON.parse(File.read("fixtures/actions/upload_department_to_fyle/input_fields.json")) }

    context "give valid input" do
      it "gives expected output" do
        expect(output_fields).to eq(expected_input_fields)
      end
    end
  end

  describe "output_fields" do
    subject(:output_fields) { action.output_fields(settings) }
    let(:expected_output_fields) { JSON.parse(File.read("fixtures/actions/upload_department_to_fyle/output_fields.json")) }

    context "give valid input" do
      it "gives expected output" do
        expect(output_fields).to eq(expected_output_fields)
      end
    end
  end
end
