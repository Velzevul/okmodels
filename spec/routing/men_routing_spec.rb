require "spec_helper"

describe MenController do
  describe "routing" do

    it "routes to #index" do
      get("/men").should route_to("men#index")
    end

    it "routes to #new" do
      get("/men/new").should route_to("men#new")
    end

    it "routes to #show" do
      get("/men/1").should route_to("men#show", :id => "1")
    end

    it "routes to #edit" do
      get("/men/1/edit").should route_to("men#edit", :id => "1")
    end

    it "routes to #create" do
      post("/men").should route_to("men#create")
    end

    it "routes to #update" do
      put("/men/1").should route_to("men#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/men/1").should route_to("men#destroy", :id => "1")
    end

  end
end
