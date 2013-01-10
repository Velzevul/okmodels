require 'spec_helper'

describe Woman do

  describe 'validations' do
    describe 'presence' do
      before do
        @woman = Woman.new
        @woman.should_not be_valid
      end

      %w(bust heaps waist).each do |attribute|
        it "has #{attribute} attribute" do 
          @woman.errors[attribute].should_not be_blank
        end
      end
    end

    %w(bust waist heaps).each do |attribute|
      it "rejects negative #{attribute}" do
        woman = FactoryGirl.build(:woman)
        woman[attribute] = -1
        woman.should_not be_valid
        woman.errors[attribute].should_not be_blank
      end
    end
  end

end
