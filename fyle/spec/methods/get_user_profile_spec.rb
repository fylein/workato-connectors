# frozen_string_literal: true

RSpec.describe "methods/get_user_profile", :vcr do

  # Learn more: https://docs.workato.com/developing-connectors/sdk/cli/reference/rspec-commands.html

  let(:connector) { Workato::Connector::Sdk::Connector.from_file("connector.rb", settings) }
  let(:settings) { Workato::Connector::Sdk::Settings.from_default_file }

  describe "given valid input" do
    subject(:result) { connector.methods.get_user_profile(settings) }
    let(:expected_output) { JSON.parse(File.read("fixtures/methods/get_user_profile/output.json")) }

    it "gives expected output" do
      expect(result.keys).to eq(expected_output.keys)
    end
  end
end
