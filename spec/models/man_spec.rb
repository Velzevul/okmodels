require 'spec_helper'

describe Man do

  describe 'validations' do
    describe 'presence' do
      before do
        @man = Man.new
        @man.should_not be_valid
      end

      %w(full_name date_of_birth email height shoes hair eyes).each do |attribute|
        it "has #{attribute} attribute" do 
          @man.errors[attribute].should_not be_blank
        end
      end
    end

    %w(height shoes).each do |attribute|
      it "rejects negative #{attribute}" do
        man = FactoryGirl.build(:man)
        man[attribute] = -1
        man.should_not be_valid
        man.errors[attribute].should_not be_blank
      end
    end

    %w(full_name email).each do |attribute|
      it "has allows only unique #{attribute}" do
        FactoryGirl.create(:man, attribute => "dummy")
        m = FactoryGirl.build(:man, attribute => "dummy")
        m.should_not be_valid
        m.errors[attribute].should_not be_blank
      end
    end

    it "rejects date_of_birth in the future" do
      man = FactoryGirl.build(:man, :date_of_birth => Date.tomorrow)
      man.should_not be_valid
      man.errors[:date_of_birth].should_not be_blank
    end
  end

  describe 'custom scopes' do
    before do
      @men = []
      10.times do
        @men << FactoryGirl.create(:man)
      end
      @nonconfirmed = FactoryGirl.create(:man, :confirmed => false)
    end

    it "returns confirmed entries by default" do
      Man.all.count.should eq(10)
    end

    it "returns non-confirmed entries" do
      Man.nonconfirmed.should eq([@nonconfirmed])
    end

    it "defaults ordering by created_at DESC" do
      Man.all.should eq(@men.reverse)
    end

    it "selects last 10 elements" do
      Man.latest(5).should eq(@men[-5..-1].reverse)
    end
  end

end
