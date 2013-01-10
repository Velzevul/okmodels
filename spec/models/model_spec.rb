require 'spec_helper'

describe Model do
  describe 'validations' do
    describe 'presence' do
      before do
        @model = Model.new
        @model.should_not be_valid
      end

      %w(full_name date_of_birth email height shoes hair eyes).each do |attribute|
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

    it "returns confirmed entries by default" do
      Model.all.count.should eq(10)
    end

    it "returns non-confirmed entries" do
      Model.nonconfirmed.should eq([@nonconfirmed])
    end

    it "defaults ordering by created_at DESC" do
      Model.all.should eq(@models.reverse)
    end

    it "selects last 10 elements" do
      Model.latest(5).should eq(@models[-5..-1].reverse)
    end
  end
end
