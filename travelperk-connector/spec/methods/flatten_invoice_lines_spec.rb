# frozen_string_literal: true

RSpec.describe "methods/flatten_invoice_lines", :vcr do

  # Learn more: https://docs.workato.com/developing-connectors/sdk/cli/reference/rspec-commands.html

  let(:connector) { Workato::Connector::Sdk::Connector.from_file("connector.rb", settings) }
  let(:settings) { Workato::Connector::Sdk::Settings.from_default_file }
  let(:input) { JSON.parse(File.read("fixtures/payload.json")) }

  describe "given valid input" do
    subject(:result) { connector.methods.flatten_invoice_lines(input) }
    let(:expected_output) { JSON.parse(File.read("fixtures/actions/flatten_invoices/output.json")) }

    it "gives expected output" do
      puts input
      expect(result).to eq(expected_output)
    end
  end
end
