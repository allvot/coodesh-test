require 'rails_helper'

RSpec.describe "api_keys/edit", type: :view do
  let(:api_key) {
    ApiKey.create!(
      name: "MyString",
      key: "MyText"
    )
  }

  before(:each) do
    assign(:api_key, api_key)
  end

  it "renders the edit api_key form" do
    render

    assert_select "form[action=?][method=?]", api_key_path(api_key), "post" do

      assert_select "input[name=?]", "api_key[name]"

      assert_select "textarea[name=?]", "api_key[key]"
    end
  end
end
