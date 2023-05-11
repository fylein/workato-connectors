# frozen_string_literal: true

RSpec.describe "object_definition/invoice_lines", :vcr do

  # Spec describes the most commons blocks of an object definition.
  # Learn more: https://docs.workato.com/developing-connectors/sdk/cli/reference/rspec-commands.html

  let(:connector) { Workato::Connector::Sdk::Connector.from_file("connector.rb") }
  let(:object_definition) { connector.object_definitions.invoice_lines }

  describe "fields" do
    subject(:schema_fields) { object_definition.fields }
    let(:expected_output) { JSON.parse(File.read("fixtures/object_definations/invoice_lines.json")) }

    context "give valid input" do
      it "gives expected output" do
        expect(schema_fields).to eq(expected_output)
      end
    end
  end
end
