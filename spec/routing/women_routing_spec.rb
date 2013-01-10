require "spec_helper"

describe WomenController do
  describe "routing" do

    it "routes to #index" do
      get("/women").should route_to("women#index")
    end

    it "routes to #new" do
      get("/women/new").should route_to("women#new")
    end

    it "routes to #show" do
      get("/women/1").should route_to("women#show", :id => "1")
    end

    it "routes to #edit" do
      get("/women/1/edit").should route_to("women#edit", :id => "1")
    end

    it "routes to #create" do
      post("/women").should route_to("women#create")
    end

    it "routes to #update" do
      put("/women/1").should route_to("women#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/women/1").should route_to("women#destroy", :id => "1")
    end

  end
end
