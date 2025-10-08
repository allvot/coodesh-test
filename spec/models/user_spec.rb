# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do
  context 'with valid attributes' do
    subject(:user) { build(:user) }

    it { is_expected.to be_valid }
    it('has a name') { expect(user.name).to be_present }
    it('has a role') { expect(user.role).to be_present }
    it('has a email') { expect(user.email).to be_present }
  end

  context 'with blank attributes' do
    subject(:user) { User.new }

    before { user.valid? }

    it { is_expected.to be_invalid }
    it('has a name cant be blank error') { expect(user.errors[:name]).to include("can't be blank") }
    it("has a 'user' role cant be blank error") { expect(user.role).to eq('user') }
    it('has a email cant be blank error') { expect(user.errors[:email]).to include("can't be blank") }
  end

  context 'with invalid role' do
    subject(:user) { build(:user, role: 'invalid') }

    before { user.valid? }

    it { is_expected.to be_invalid }
    it('has a role cant be invalid error') { expect(user.errors[:role]).to include('is not included in the list') }
  end

  context 'with invalid email' do
    let(:other_user) { create(:user) }

    subject(:user) { build(:user, email: other_user.email) }

    before { user.valid? }

    it { is_expected.to be_invalid }
    it('has a email has already been taken error') { expect(user.errors[:email]).to include('has already been taken') }
  end
end

describe User, '#api_keys' do
  let(:user) { create(:user) }
  subject(:api_keys) { user.api_keys }

  context 'with api keys' do
    let!(:api_keys) { create_list(:api_key, 3, user: user) }

    it('has many api keys') { expect(api_keys).to all(be_a(ApiKey)) }
    it('has many api keys') { expect(api_keys.count).to eq(3) }
  end

  context 'without api keys' do
    it { is_expected.to be_empty }
  end
end
