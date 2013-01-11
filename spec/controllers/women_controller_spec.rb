require 'spec_helper'

describe WomenController do

  describe "GET index" do
    it "filters by parameters" do
      entries = FactoryGirl.create_list(:woman, 5)
      first = entries.first
      get :index, {:search => {:full_name_contains => first.full_name, 
                               :date_of_birth_equals => first.date_of_birth, 
                               :height_equals => first.height,
                               :shoes_equals => first.shoes,
                               :hair_equals => first.hair,
                               :eyes_equals => first.eyes,
                               :bust_equals => first.bust,
                               :waist_equals => first.waist,
                               :heaps_equals => first.heaps}}
      assigns(:women).should eq([entries.first])
    end
  end

  describe "POST create" do
    it "accepts nested attributes for a Photo" do
      attributes = FactoryGirl.attributes_for(:woman).merge!(:photos_attributes => [FactoryGirl.attributes_for(:photo)])
      lambda {
      lambda {
          post :create, {:woman => attributes}
      }.should change(Woman, :count).by(1)
      }.should change(Photo, :count).by(1)
    end
  end

end
