require 'rails_helper'

describe "Api::Documents", type: :request do
  describe "GET /index" do
    subject(:get_request) { get api_vault_documents_path(vault), headers: }

    let(:user) { create(:user) }
    let(:vault) { create(:vault, user: user) }
    let(:documents) { create_list(:document, 3, vault: vault) }

    context "when logged in with a read key" do
      let(:api_key) { create(:api_key, :read, user: user) }
      let(:headers) { { 'Authorization' => "Bearer #{api_key.key}" } }

      it "returns a successful response" do
        get_request
        expect(response).to be_successful
      end

      it "returns the documents" do
        get_request
        expect(json_data).to match_json_response(documents)
      end
    end

    context "when logged in with a write key" do
      let(:api_key) { create(:api_key, :write, user: user) }
      let(:headers) { { 'Authorization' => "Bearer #{api_key.key}" } }

      it "returns a successful response" do
        get_request
        expect(response).to be_successful
      end

      it "returns the documents" do
        get_request
        expect(json_data).to match_json_response(documents)
      end
    end

    context "when not logged in" do
      let(:headers) { {} }

      it "returns a unauthorized response" do
        get_request
        expect(response).to be_unauthorized
      end
    end
  end
end
