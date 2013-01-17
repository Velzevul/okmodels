require 'spec_helper'

describe MainController do

  describe "GET 'latest'" do
    it "retrieves latest 25 models " do
      entries = FactoryGirl.create_list(:model, 26)
      get :latest
      assigns(:models).should eq(entries[1..26].reverse)
    end
  end

end
