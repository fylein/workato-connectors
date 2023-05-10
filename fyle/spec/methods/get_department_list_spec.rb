# frozen_string_literal: true

RSpec.describe "methods/get_department_list", :vcr do

  # Learn more: https://docs.workato.com/developing-connectors/sdk/cli/reference/rspec-commands.html

  let(:connector) { Workato::Connector::Sdk::Connector.from_file("connector.rb", settings) }
  let(:settings) { Workato::Connector::Sdk::Settings.from_default_file }
  let(:input) { JSON.parse(File.read("fixtures/methods/get_department_list/input.json")) }

  describe "given valid input" do
    subject(:result) { connector.methods.get_department_list(input, settings) }
    let(:expected_output) { JSON.parse(File.read("fixtures/methods/get_department_list/output.json")) }

    it "gives expected output" do
      expect(result["data"]).to eq(expected_output)
    end
  end
end
