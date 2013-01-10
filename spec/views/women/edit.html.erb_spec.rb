require 'spec_helper'

describe "women/edit" do
  before(:each) do
    @woman = assign(:woman, stub_model(Woman,
      :full_name => "MyString",
      :email => "MyString",
      :height => 1,
      :shoes => 1,
      :hair => "MyString",
      :eyes => "MyString",
      :confirmed => false,
      :bust => 1,
      :waist => 1,
      :heaps => 1
    ))
  end

  it "renders the edit woman form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => women_path(@woman), :method => "post" do
      assert_select "input#woman_full_name", :name => "woman[full_name]"
      assert_select "input#woman_email", :name => "woman[email]"
      assert_select "input#woman_height", :name => "woman[height]"
      assert_select "input#woman_shoes", :name => "woman[shoes]"
      assert_select "input#woman_hair", :name => "woman[hair]"
      assert_select "input#woman_eyes", :name => "woman[eyes]"
      assert_select "input#woman_confirmed", :name => "woman[confirmed]"
      assert_select "input#woman_bust", :name => "woman[bust]"
      assert_select "input#woman_waist", :name => "woman[waist]"
      assert_select "input#woman_heaps", :name => "woman[heaps]"
    end
  end
end
