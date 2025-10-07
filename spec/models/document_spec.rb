require 'rails_helper'

describe Document do
  context "with valid attributes" do
    subject(:document) { create(:document) }

    it { is_expected.to be_valid }
    it("has a name") { expect(document.name).to be_present }
    it("has a vault") { expect(document.vault).to be_present }
  end

  context "with blank attributes" do
    subject(:document) { Document.new }

    before { document.valid? }

    it { is_expected.to be_invalid }
    it("has a name cant be blank error") { expect(document.errors[:name]).to include("can't be blank") }
    it("has a vault must exist error") { expect(document.errors[:vault]).to include("must exist") }
  end
end
