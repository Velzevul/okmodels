require 'spec_helper'

describe WomenController do

  describe "GET index" do
    it "returnes only approved entries" do
      approved = FactoryGirl.create(:woman)
      nonapproved = FactoryGirl.create(:woman, :confirmed => false)
      get :index
      assigns(:women).should eq([approved])
    end

    it "filters by parameters" do
      entries = FactoryGirl.create_list(:woman, 5)
      first = entries.first
      get :index, {:search => {:full_name_equals => first.full_name}}
      assigns(:women).should eq([entries.first])
    end
  end

  describe "GET new" do
    it "creates associated first photo" do
      get :new
      assigns(:woman).photos.should_not be_blank
    end
  end

  describe "POST create" do
    it "accepts nested attributes for a Photo" do
      attributes = FactoryGirl.attributes_for(:woman).merge!(:photos_attributes => FactoryGirl.attributes_for_list(:photo,3))
      lambda {
      lambda {
          post :create, {:woman => attributes}
      }.should change(Woman, :count).by(1)
      }.should change(Photo, :count).by(3)
    end
  end

end
