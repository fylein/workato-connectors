# frozen_string_literal: true

RSpec.describe "methods/get_category_id", :vcr do

  # Learn more: https://docs.workato.com/developing-connectors/sdk/cli/reference/rspec-commands.html

  let(:connector) { Workato::Connector::Sdk::Connector.from_file("connector.rb", settings) }
  let(:settings) { Workato::Connector::Sdk::Settings.from_default_file }

  describe "given valid input" do
    subject(:result) { connector.methods.get_category_id(settings, "Airlines") }
    let(:expected_output) { JSON.parse(File.read("fixtures/methods/get_department_list/output.json")) }
    
    it "gives expected output" do
      expect(result).to eq(116918)
    end
  end
end
