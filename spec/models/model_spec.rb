require 'spec_helper'

describe Model do
  describe 'validations' do
    describe 'presence' do
      before do
        @model = Model.new
        @model.should_not be_valid
      end

      %w(full_name date_of_birth email phone city height shoes hair eyes).each do |attribute|
        it "has #{attribute} attribute" do 
          @model.errors[attribute].should_not be_blank
        end
      end
    end

    %w(height shoes).each do |attribute|
      it "rejects negative #{attribute}" do
        model = FactoryGirl.build(:model)
        model[attribute] = -1
        model.should_not be_valid
        model.errors[attribute].should_not be_blank
      end
    end

    %w(full_name email).each do |attribute|
      it "has allows only unique #{attribute}" do
        FactoryGirl.create(:model, attribute => "dummy")
        m = FactoryGirl.build(:model, attribute => "dummy")
        m.should_not be_valid
        m.errors[attribute].should_not be_blank
      end
    end

    it "rejects date_of_birth in the future" do
      model = FactoryGirl.build(:model, :date_of_birth => Date.tomorrow)
      model.should_not be_valid
      model.errors[:date_of_birth].should_not be_blank
    end
  end

  describe 'custom scopes' do
    before do
      @models = FactoryGirl.create_list(:model, 10)
      @nonconfirmed = FactoryGirl.create(:model, :confirmed => false)
    end

    it "returns confirmed entries" do
      Model.confirmed.count.should eq(10)
    end

    it "returns non-confirmed entries" do
      Model.nonconfirmed.should eq([@nonconfirmed])
    end

    it "defaults ordering by created_at DESC" do
      Model.confirmed.should eq(@models.reverse)
    end

    it "selects last 5 elements" do
      Model.latest(5).should eq(@models[-5..-1].reverse)
    end
  end

  describe 'associations' do
    it "has many photos" do
      Model.new.should respond_to(:photos)
    end

    it "returns photos" do
      non_related_photo = FactoryGirl.create(:photo)
      model = FactoryGirl.create(:model, :with_photos)
      model.photos.should eq(Photo.all - [non_related_photo])
    end

    it "should delete all associated photo on model destroy" do
      m = FactoryGirl.create(:model, :with_photos)
      Photo.where(:model_id => m.id).should_not be_blank
      m.destroy
      Photo.where(:model_id => m.id).should be_blank
    end
  end
end
