require 'rails_helper'

describe Vault do
  context "with valid attributes" do
    subject(:vault) { create(:vault) }

    it { is_expected.to be_valid }
    it("has a name") { expect(vault.name).to be_present }
    it("has a user") { expect(vault.user).to be_present }
  end

  context "with blank attributes" do
    subject(:vault) { Vault.new }

    before { vault.valid? }

    it { is_expected.to be_invalid }
    it("has a name cant be blank error") { expect(vault.errors[:name]).to include("can't be blank") }
    it("has a user must exist error") { expect(vault.errors[:user]).to include("must exist") }
  end
end

describe Vault, "#documents" do
  let(:vault) { create(:vault) }
  subject(:documents) { vault.documents }

  context "with documents" do
    let!(:documents) { create_list(:document, 3, vault: vault) }

    it("has many documents") { expect(documents).to all(be_a(Document)) }
    it("has many documents") { expect(documents.count).to eq(3) }
  end

  context "without documents" do
    it { is_expected.to be_empty }
  end
end
