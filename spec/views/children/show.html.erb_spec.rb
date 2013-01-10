require 'spec_helper'

describe "children/show" do
  before(:each) do
    @child = assign(:child, stub_model(Child,
      :full_name => "Full Name",
      :email => "Email",
      :height => 1,
      :shoes => 2,
      :hair => "Hair",
      :eyes => "Eyes",
      :confirmed => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Full Name/)
    rendered.should match(/Email/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Hair/)
    rendered.should match(/Eyes/)
    rendered.should match(/false/)
  end
end
