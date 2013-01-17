require 'spec_helper'

describe MainController do

  describe "GET 'latest'" do
    it "retrieves latest 25 models " do
      entries = FactoryGirl.create_list(:model, 26)
      get :latest
      assigns(:models).should eq(entries[1..26].reverse)
    end
  end

  describe "GET 'new_applications'" do
    it "shows nonconfirmed models only" do
      confirmed = FactoryGirl.create(:model)
      nonconfirmed = FactoryGirl.create(:model, :confirmed => false)
      get :new_applications
      assigns(:models).should eq([nonconfirmed])
    end
  end

  describe "GET 'approve'" do
    before do
      @model = FactoryGirl.create(:man, :confirmed => false)
      get :approve, :id => @model.id
    end

    it "finds requested model" do
      assigns(:model).should eq(@model)
    end

    it "approves model" do
      @model.reload.confirmed.should be_true
    end

    it "redirects to the model's page" do
      request.should redirect_to @model
    end
  end
end
