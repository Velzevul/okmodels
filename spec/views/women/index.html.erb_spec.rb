require 'spec_helper'

describe "women/index" do
  before(:each) do
    assign(:women, [
      stub_model(Woman,
        :full_name => "Full Name",
        :email => "Email",
        :height => 1,
        :shoes => 2,
        :hair => "Hair",
        :eyes => "Eyes",
        :confirmed => false,
        :bust => 3,
        :waist => 4,
        :heaps => 5
      ),
      stub_model(Woman,
        :full_name => "Full Name",
        :email => "Email",
        :height => 1,
        :shoes => 2,
        :hair => "Hair",
        :eyes => "Eyes",
        :confirmed => false,
        :bust => 3,
        :waist => 4,
        :heaps => 5
      )
    ])
  end

  it "renders a list of women" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Full Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Hair".to_s, :count => 2
    assert_select "tr>td", :text => "Eyes".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
  end
end
