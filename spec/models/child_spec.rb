require 'spec_helper'

describe Child do

  describe 'validations' do
    describe 'presence' do
      before do
        @child = Child.new
        @child.should_not be_valid
      end

      %w(full_name date_of_birth email height shoes hair eyes).each do |attribute|
        it "has #{attribute} attribute" do 
          @child.errors[attribute].should_not be_blank
        end
      end
    end

    %w(height shoes).each do |attribute|
      it "rejects negative #{attribute}" do
        child = FactoryGirl.build(:child)
        child[attribute] = -1
        child.should_not be_valid
        child.errors[attribute].should_not be_blank
      end
    end

    %w(full_name email).each do |attribute|
      it "has allows only unique #{attribute}" do
        FactoryGirl.create(:child, attribute => "dummy")
        c = FactoryGirl.build(:child, attribute => "dummy")
        c.should_not be_valid
        c.errors[attribute].should_not be_blank
      end
    end

    it "rejects date_of_birth in the future" do
      child = FactoryGirl.build(:child, :date_of_birth => Date.tomorrow)
      child.should_not be_valid
      child.errors[:date_of_birth].should_not be_blank
    end
  end

  describe 'custom scopes' do
    before do
      @children = []
      10.times do
        @children << FactoryGirl.create(:child)
      end
      @nonconfirmed = FactoryGirl.create(:child, :confirmed => false)
    end

    it "returns confirmed entries by default" do
      Child.all.count.should eq(10)
    end

    it "returns non-confirmed entries" do
      Child.nonconfirmed.should eq([@nonconfirmed])
    end

    it "defaults ordering by created_at DESC" do
      Child.all.should eq(@children.reverse)
    end

    it "selects last 10 elements" do
      Child.latest(5).should eq(@children[-5..-1].reverse)
    end
  end

end
