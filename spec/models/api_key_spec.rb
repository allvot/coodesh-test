require 'rails_helper'

describe ApiKey do
  context "with valid attributes" do
    subject(:api_key) { create(:api_key) }

    it { is_expected.to be_valid }
    it("has a key") { expect(api_key.key).to be_present }
    it("has a name") { expect(api_key.name).to be_present }
    it("has a user") { expect(api_key.user).to be_present }
  end

  context "with blank attributes" do
    subject(:api_key) { ApiKey.new }

    before { api_key.valid? }

    it { is_expected.to be_invalid }
    it("has a key cant be blank error") { expect(api_key.errors[:key]).to include("can't be blank") }
    it("has a name cant be blank error") { expect(api_key.errors[:name]).to include("can't be blank") }
    it("has a user must exist error") { expect(api_key.errors[:user]).to include("must exist") }
  end
end
