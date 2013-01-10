require 'spec_helper'

describe "children/index" do
  before(:each) do
    assign(:children, [
      stub_model(Child,
        :full_name => "Full Name",
        :email => "Email",
        :height => 1,
        :shoes => 2,
        :hair => "Hair",
        :eyes => "Eyes",
        :confirmed => false
      ),
      stub_model(Child,
        :full_name => "Full Name",
        :email => "Email",
        :height => 1,
        :shoes => 2,
        :hair => "Hair",
        :eyes => "Eyes",
        :confirmed => false
      )
    ])
  end

  it "renders a list of children" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Full Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Hair".to_s, :count => 2
    assert_select "tr>td", :text => "Eyes".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
