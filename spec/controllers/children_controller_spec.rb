require 'spec_helper'

describe ChildrenController do

  describe "GET index" do
    it "filters by parameters" do
      entries = FactoryGirl.create_list(:child, 5)
      first = entries.first
      get :index, {:search => {:full_name_equals => first.full_name}}
      assigns(:children).should eq([entries.first])
    end
  end

  describe "GET new" do
    it "creates associated first photo" do
      get :new
      assigns(:child).photos.should_not be_blank
    end
  end

  describe "POST create" do
    it "accepts nested attributes for a Photo" do
      attributes = FactoryGirl.attributes_for(:child).merge!(:photos_attributes => FactoryGirl.attributes_for_list(:photo,3))
      lambda {
      lambda {
          post :create, {:child => attributes}
      }.should change(Child, :count).by(1)
      }.should change(Photo, :count).by(3)
    end
  end

end
