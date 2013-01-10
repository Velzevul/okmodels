require 'spec_helper'

describe "women/show" do
  before(:each) do
    @woman = assign(:woman, stub_model(Woman,
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
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/5/)
  end
end
