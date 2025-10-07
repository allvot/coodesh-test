require 'rails_helper'

RSpec.describe "api_keys/index", type: :view do
  before(:each) do
    assign(:api_keys, [
      ApiKey.create!(
        name: "Name",
        key: "MyText"
      ),
      ApiKey.create!(
        name: "Name",
        key: "MyText"
      )
    ])
  end

  it "renders a list of api_keys" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
  end
end
