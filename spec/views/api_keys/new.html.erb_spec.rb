require 'rails_helper'

RSpec.describe "api_keys/new", type: :view do
  before(:each) do
    assign(:api_key, ApiKey.new(
      name: "MyString",
      key: "MyText"
    ))
  end

  it "renders new api_key form" do
    render

    assert_select "form[action=?][method=?]", api_keys_path, "post" do

      assert_select "input[name=?]", "api_key[name]"

      assert_select "textarea[name=?]", "api_key[key]"
    end
  end
end
