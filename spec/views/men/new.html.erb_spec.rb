require 'spec_helper'

describe "men/new" do
  before(:each) do
    assign(:man, stub_model(Man,
      :full_name => "MyString",
      :email => "MyString",
      :height => 1,
      :shoes => 1,
      :hair => "MyString",
      :eyes => "MyString",
      :confirmed => false
    ).as_new_record)
  end

  it "renders new man form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => men_path, :method => "post" do
      assert_select "input#man_full_name", :name => "man[full_name]"
      assert_select "input#man_email", :name => "man[email]"
      assert_select "input#man_height", :name => "man[height]"
      assert_select "input#man_shoes", :name => "man[shoes]"
      assert_select "input#man_hair", :name => "man[hair]"
      assert_select "input#man_eyes", :name => "man[eyes]"
      assert_select "input#man_confirmed", :name => "man[confirmed]"
    end
  end
end
