require 'spec_helper'

describe MainController do

  describe "GET 'latest'" do
    %w(man woman child).each do |category|
      it "retrieves latest 10 #{category.pluralize}" do
        entries = FactoryGirl.create_list(category, 11)
        get :latest
        assigns(category.pluralize).should eq(entries[1..11].reverse)
      end
    end
  end

end
