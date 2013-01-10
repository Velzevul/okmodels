require 'spec_helper'

describe Woman do

  describe 'validations' do
    describe 'presence' do
      before do
        @woman = Woman.new
        @woman.should_not be_valid
      end

      %w(full_name date_of_birth email height shoes hair eyes bust heaps waist).each do |attribute|
        it "has #{attribute} attribute" do 
          @woman.errors[attribute].should_not be_blank
        end
      end
    end

    %w(height shoes bust waist heaps).each do |attribute|
      it "rejects negative #{attribute}" do
        woman = FactoryGirl.build(:woman)
        woman[attribute] = -1
        woman.should_not be_valid
        woman.errors[attribute].should_not be_blank
      end
    end

    %w(full_name email).each do |attribute|
      it "has allows only unique #{attribute}" do
        FactoryGirl.create(:woman, attribute => "dummy")
        w = FactoryGirl.build(:woman, attribute => "dummy")
        w.should_not be_valid
        w.errors[attribute].should_not be_blank
      end
    end

    it "rejects date_of_birth in the future" do
      woman = FactoryGirl.build(:woman, :date_of_birth => Date.tomorrow)
      woman.should_not be_valid
      woman.errors[:date_of_birth].should_not be_blank
    end
  end

  describe 'custom scopes' do
    before do
      @women = []
      10.times do
        @women << FactoryGirl.create(:woman)
      end
      @nonconfirmed = FactoryGirl.create(:woman, :confirmed => false)
    end

    it "returns confirmed entries by default" do
      Woman.all.count.should eq(10)
    end

    it "returns non-confirmed entries" do
      Woman.nonconfirmed.should eq([@nonconfirmed])
    end

    it "defaults ordering by created_at DESC" do
      Woman.all.should eq(@women.reverse)
    end

    it "selects last 10 elements" do
      Woman.latest(5).should eq(@women[-5..-1].reverse)
    end
  end

end
