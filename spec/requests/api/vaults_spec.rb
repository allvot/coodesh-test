require 'rails_helper'

RSpec.describe "Api::Vaults", type: :request do
  describe "GET /index" do
    subject(:index_request) { get api_vaults_path, headers: }

    let(:user) { create(:user) }
    let(:api_key) { create(:api_key, user: user) }

    context "when logged in with a read key" do
      let(:api_key) { create(:api_key, :read, user: user) }
      let!(:vault) { create(:vault, user: user) }
      let(:headers) { { 'Authorization' => "Bearer #{api_key.key}" } }

      it "returns a successful response" do
        index_request
        expect(response).to be_successful
      end

      it "returns the vaults" do
        index_request
        expect(json_data).to match_json_response(vault)
      end
    end

    context "when logged in with a read key" do
      let(:api_key) { create(:api_key, :read, user: user) }
      let!(:vault) { create(:vault, user: user) }
      let(:headers) { { 'Authorization' => "Bearer #{api_key.key}" } }

      it "returns a successful response" do
        index_request
        expect(response).to be_successful
      end
    end
  end
end
