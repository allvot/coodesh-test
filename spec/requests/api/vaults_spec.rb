require 'rails_helper'

RSpec.describe "Api::Vaults", type: :request do
  describe "GET /index" do
    let(:user) { create(:user) }
    let(:api_key) { create(:api_key, user: user) }

    context "when logged in" do
      let(:vault) { create(:vault, user: user) }

      before { get api_vaults_path, headers: { 'Authorization' => "Bearer #{api_key.key}" } }

      it "returns a successful response" do
        expect(response).to be_successful
      end
    end
  end
end
