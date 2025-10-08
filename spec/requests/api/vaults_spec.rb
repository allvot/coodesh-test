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

    context "when logged in with a write key" do
      let(:api_key) { create(:api_key, :write, user: user) }
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
  end

  describe "GET /show" do
    subject(:show_request) { get api_vault_path(vault), headers: }

    let(:user) { create(:user) }
    let(:api_key) { create(:api_key, user: user) }

    context "when logged in with a read key" do
      let(:api_key) { create(:api_key, :read, user: user) }
      let(:vault) { create(:vault, user: user) }
      let(:headers) { { 'Authorization' => "Bearer #{api_key.key}" } }

      it "returns a successful response" do
        show_request
        expect(response).to be_successful
      end

      it "returns the vault" do
        show_request
        expect(json_data).to match_json_response(vault)
      end
    end

    context "when logged in with a write key" do
      let(:api_key) { create(:api_key, :write, user: user) }
      let(:vault) { create(:vault, user: user) }
      let(:headers) { { 'Authorization' => "Bearer #{api_key.key}" } }

      it "returns a successful response" do
        show_request
        expect(response).to be_successful
      end

      it "returns the vault" do
        show_request
        expect(json_data).to match_json_response(vault)
      end
    end
  end

  describe "POST /create" do
    subject(:create_request) { post api_vaults_path, params:, headers: }

    let(:user) { create(:user) }
    let(:api_key) { create(:api_key, user: user) }

    context "when logged in with a write key" do
      let(:api_key) { create(:api_key, :write, user: user) }
      let(:headers) { { 'Authorization' => "Bearer #{api_key.key}" } }

      context "with valid parameters" do
        let(:params) do
          {
            vault: {
              name: "Test Vault",
              documents_attributes: [
                {
                  name: "Test Document",
                  file: fixture_file_upload(Rails.root.join('spec/fixtures/files/test.txt'), 'text/plain')
                }
              ]
            }
          }
        end

        it "returns a successful response" do
          create_request
          expect(response).to be_successful
        end

        it "creates a vault" do
          expect { create_request }.to change(Vault, :count).by(1)
        end

        it "creates the documents" do
          expect { create_request }.to change(Document, :count).by(1)
        end
      end

      context "with invalid parameters" do
        let(:params) do
          {
            vault: {
              name: nil
            }
          }
        end

        it "returns a unprocessable entity response" do
          create_request
          expect(response).to be_unprocessable
        end

        it "returns the errors" do
          create_request
          expect(json_errors).to be_present
        end
      end
    end

    context "when logged in with a read key" do
      let(:api_key) { create(:api_key, :read, user: user) }
      let(:headers) { { 'Authorization' => "Bearer #{api_key.key}" } }

      let(:params) do
        {
          vault: {
            name: "Test Vault"
          }
        }
      end

      it "returns a unauthorized response" do
        create_request
        expect(response).to be_unauthorized
      end
    end
  end

  describe "POST /update" do
    subject(:update_request) { put api_vault_path(vault), params:, headers: }

    let(:user) { create(:user) }
    let(:api_key) { create(:api_key, user: user) }

    context "when logged in with a write key" do
      let(:api_key) { create(:api_key, :write, user: user) }
      let(:headers) { { 'Authorization' => "Bearer #{api_key.key}" } }

      context "with valid parameters" do
        let!(:vault) { create(:vault, user: user) }
        let(:params) do
          {
            vault: {
              name: "Test Vault",
              documents_attributes: [
                {
                  name: "Test Document",
                  file: fixture_file_upload(Rails.root.join('spec/fixtures/files/test.txt'), 'text/plain')
                }
              ]
            }
          }
        end

        it "returns a successful response" do
          update_request
          expect(response).to be_successful
        end

        it "updates the vault" do
          update_request
          expect(vault.reload.name).to eq("Test Vault")
        end

        it "updates the documents" do
          update_request
          expect(vault.documents.first.name).to eq("Test Document")
        end

        it "does not create a vault" do
          expect { update_request }.to change(Vault, :count).by(0)
        end

        it "does not create the documents" do
          expect { update_request }.to change(Document, :count).by(1)
        end
      end

      context "with invalid parameters" do
        let(:vault) { create(:vault, user: user) }
        let(:params) do
          {
            vault: {
              name: nil
            }
          }
        end

        it "returns a unprocessable entity response" do
          update_request
          expect(response).to be_unprocessable
        end

        it "returns the errors" do
          update_request
          expect(json_errors).to be_present
        end
      end
    end

    context "when logged in with a read key" do
      let(:api_key) { create(:api_key, :read, user: user) }
      let(:headers) { { 'Authorization' => "Bearer #{api_key.key}" } }
      let!(:vault) { create(:vault, user: user) }
      let(:params) do
        {
          vault: {
            name: "Test Vault"
          }
        }
      end

      it "returns a unauthorized response" do
        update_request
        expect(response).to be_unauthorized
      end
    end
  end


  describe "DELETE /destroy" do
    subject(:destroy_request) { delete api_vault_path(vault), headers: }

    let(:user) { create(:user) }
    let(:api_key) { create(:api_key, user: user) }

    context "when logged in with a write key" do
      let(:api_key) { create(:api_key, :write, user: user) }
      let(:headers) { { 'Authorization' => "Bearer #{api_key.key}" } }

      context "with valid parameters" do
        let!(:vault) { create(:vault, user: user) }
        let(:params) do
          {
            vault: {
              name: "Test Vault",
              documents_attributes: [
                {
                  name: "Test Document",
                  file: fixture_file_upload(Rails.root.join('spec/fixtures/files/test.txt'), 'text/plain')
                }
              ]
            }
          }
        end

        it "returns a successful response" do
          destroy_request
          expect(response).to be_no_content
        end

        it "destroys a vault" do
          expect { destroy_request }.to change(Vault, :count).to(0)
        end
      end

      context "for a vault that does not belong to the user" do
        let(:vault) { create(:vault) }
        let(:params) do
          {
            vault: {
              name: nil
            }
          }
        end

        it "returns a not found response" do
          destroy_request
          expect(response).to be_not_found
        end
      end
    end

    context "when logged in with a read key" do
      let(:api_key) { create(:api_key, :read, user: user) }
      let(:headers) { { 'Authorization' => "Bearer #{api_key.key}" } }
      let!(:vault) { create(:vault, user: user) }
      let(:params) do
        {
          vault: {
            name: "Test Vault"
          }
        }
      end

      it "returns a unauthorized response" do
        destroy_request
        expect(response).to be_unauthorized
      end
    end
  end
end
