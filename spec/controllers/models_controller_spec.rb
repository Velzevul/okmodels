require 'spec_helper'

describe ModelsController do

  describe "GET index" do
    it "returnes only approved entries" do
      approved = FactoryGirl.create(:man)
      nonapproved = FactoryGirl.create(:man, :confirmed => false)
      get :index, :type => "Man"
      assigns(:models).should eq([approved])
    end

    it "filters by parameters" do
      entries = FactoryGirl.create_list(:man, 5)
      first = entries.first
      get :index, :type => "Man", :search => {:full_name_equals => first.full_name}
      assigns(:models).should eq([entries.first])
    end
  end

  describe "GET show" do
    it "finds requested record" do
      model = FactoryGirl.create(:man)
      get :show, :id => model, :type => "Man"
      assigns(:model).should eq(model)
    end
  end

  describe "GET new" do
    it "creates a new model" do
      get :new, :type => "Man"
      assigns(:model).should_not be_blank
      assigns(:model).should be_a_new(Model)
    end

    it "creates associated photos" do
      get :new, :type => "Man"
      assigns(:model).photos.length.should eq(3)
    end
  end

  describe "POST create" do
    before do
      @attributes = {:type => "Man", 
                     :man => FactoryGirl.attributes_for(:man).merge!(:photos_attributes => FactoryGirl.attributes_for_list(:photo, 3))}
    end

    it "assigns model variable" do
      post :create, @attributes
      assigns(:model).should_not be_blank
      assigns(:model).should be_valid
    end

    context "on success" do
      it "redirects to the root page" do
        post :create, @attributes
        response.should redirect_to(root_path)
      end

      it "shows a `success` notice" do
        post :create, @attributes
        flash[:notice].should eq("Thank you for your application. It will be now reviewed by the administrator")
      end

      it "accepts nested attributes for a Photo" do
        lambda {
        lambda {
            post :create, @attributes
        }.should change(Model, :count).by(1)
        }.should change(Photo, :count).by(3)
      end
    end

    context "on failure" do
      before do
        @attributes[:man] = nil
      end

      it "re-renders form" do
        post :create, @attributes 
        response.should render_template('new')
      end

      it "does not create a new record" do
        lambda {
        lambda {
          post :create, @attributes
        }.should_not change(Model, :count)
        }.should_not change(Photo, :count)
      end
    end
  end

  describe "GET 'latest'" do
    it "retrieves latest 25 models " do
      entries = FactoryGirl.create_list(:model, 26)
      get :latest
      assigns(:models).should eq(entries[1..26].reverse)
    end
  end

  context "as admin" do
    before do 
      sign_in FactoryGirl.create(:user, :admin)
    end

    describe "GET 'new_applications'" do
      it "shows nonconfirmed models only" do
        confirmed = FactoryGirl.create(:model)
        nonconfirmed = FactoryGirl.create(:model, :confirmed => false)
        get :new_applications
        assigns(:models).should eq([nonconfirmed])
      end
    end

    describe "PUT update" do
      before do
        @model = FactoryGirl.create(:man)
        @attributes = {:type => "Man",
                       :id => @model,
                       :man => {:full_name => "Vasa Pupkin"}}
      end

      it "finds the requested record" do
        put :update, @attributes
        assigns(:model).should eq(@model)
      end

      context "on success" do
        it "updates attributes" do
          put :update, @attributes
          assigns(:model).full_name.should eq("Vasa Pupkin")
        end

        it "redirects a model's page" do
          put :update, @attributes
          response.should redirect_to(@model)
        end
      end

      context "on failure" do
        before do
          @attributes[:man][:full_name] = nil
        end

        it "does not change model" do
          put :update, @attributes
          assigns(:model).full_name.should_not be_nil
        end

        it "re-renders the form" do
          put :update, @attributes
          response.should render_template('edit')
        end
      end
    end

    describe "DELETE destroy" do
      before do
        @model = FactoryGirl.create(:man)
        @attributes = {:type => "Man",
                       :id => @model}
      end

      it "deletes a record" do
        lambda {
          delete :destroy, @attributes
        }.should change(Model,:count).by(-1)
      end

      context "if confirmed" do
        it "redirects to men_path" do
          delete :destroy, @attributes
          response.should redirect_to men_url
        end
      end

      context "if non-confirmed" do
        it "redirects to new applications" do
          @model.confirmed = false
          @model.save
          delete :destroy, @attributes
          response.should redirect_to new_applications_url
        end
      end
    end

    describe "GET 'approve'" do
      before do
        @model = FactoryGirl.create(:man, :confirmed => false)
        get :approve, :type => "Man", :id => @model.id
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
end
