require 'rails_helper'

RSpec.describe "api_keys/show", type: :view do
  before(:each) do
    assign(:api_key, ApiKey.create!(
      name: "Name",
      key: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
  end
end
