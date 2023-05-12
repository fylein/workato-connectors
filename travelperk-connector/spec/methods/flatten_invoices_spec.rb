# frozen_string_literal: true

RSpec.describe "methods/flatten_invoices", :vcr do

  # Learn more: https://docs.workato.com/developing-connectors/sdk/cli/reference/rspec-commands.html

  let(:connector) { Workato::Connector::Sdk::Connector.from_file("connector.rb", settings) }
  let(:settings) { Workato::Connector::Sdk::Settings.from_default_file }
  let(:input) { JSON.parse(File.read("fixtures/payload.json")) }

  describe "given valid input" do
    subject(:result) { connector.methods.flatten_invoices([input]) }
    it "gives expected output" do
      expect(result["data"][0]["pdf"]).to eq("https://api.travelperk.com/invoices/INV-01-1234/pdf")
    end
  end
end
