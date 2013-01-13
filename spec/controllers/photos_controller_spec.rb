require 'spec_helper'

describe PhotosController do
  %w(man woman child).each do |model_type|
    describe "in case of #{model_type}" do
      before do
        @model = FactoryGirl.create(model_type)
      end

      describe "GET 'new'" do
        it "builds a new photo for a #{model_type}" do
          get :new, (model_type + "_id") => @model.id
          assigns(:photo).should_not be_nil
          assigns(:photo).should be_a_new(Photo)  
        end
      end

      describe "POST 'create'" do
        before do
          @params = { :photo => FactoryGirl.attributes_for(:photo, :model => @model),
                      model_type + "_id" => @model.id }
        end

        it "assigns @photo variable" do
          post :create, @params
          assigns(:photo).should_not be_nil
          assigns(:photo).should be_instance_of(Photo)
        end

        context "on success" do
          it "redirects to a model's page" do
            post :create, @params
            response.should redirect_to @model
          end

          it "creates a new photo" do
            lambda { post :create, @params }.should change(Photo, :count).by(1)
          end
        end

        context "on fail" do
          before do
            @params[:photo] = {}
          end

          it "re-renders the form" do
            post :create, @params
            response.should render_template("new")
          end

          it "does not create new record" do
            lambda { post :create, @params }.should_not change(Photo, :count)
          end
        end
      end

      describe "DELETE 'destroy" do
        before do
          FactoryGirl.create(:photo, :model => @model)
          @params = {:id => Photo.first.id, model_type + "_id" => @model.id}
        end

        it "deletes a photo" do
          lambda {
            delete :destroy, @params
          }.should change(Photo, :count).by(-1)
        end

        it "redirects to a model's page with a notification" do
          delete :destroy, @params
          response.should redirect_to @model
          flash[:notice].should eq("Photo was successfully deleted")
        end
      end
    end
  end  
end
