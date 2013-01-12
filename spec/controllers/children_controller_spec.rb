require 'spec_helper'

describe ChildrenController do

  describe "GET index" do
    it "filters by parameters" do
      entries = FactoryGirl.create_list(:child, 5)
      first = entries.first
      get :index, {:search => {:full_name_contains => first.full_name, 
                               :date_of_birth_equals => first.date_of_birth, 
                               :height_equals => first.height,
                               :shoes_equals => first.shoes,
                               :hair_equals => first.hair,
                               :eyes_equals => first.eyes}}
      assigns(:children).should eq([entries.first])
    end
  end

  describe "GET new" do
    it "creates associated first photo" do
      get :new
      assigns(:photo).should_not be_blank
    end
  end

  describe "POST create" do
    it "accepts nested attributes for a Photo" do
      attributes = FactoryGirl.attributes_for(:child).merge!(:photos_attributes => [FactoryGirl.attributes_for(:photo)])
      lambda {
      lambda {
          post :create, {:child => attributes}
      }.should change(Child, :count).by(1)
      }.should change(Photo, :count).by(1)
    end
  end

end
