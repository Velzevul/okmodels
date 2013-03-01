require 'spec_helper'

describe Photo do

  it { should have_attached_file(:image) }
  it { should validate_attachment_presence(:image) }
  it { should validate_attachment_content_type(:image).
                 allowing('image/jpg', 'image/jpeg', 'image/gif').
                 rejecting('text/plain', 'text/xml')}
  it { should validate_attachment_size(:image).
                 less_than(200.kilobytes)}

  describe "associations" do
    before do
      @m = FactoryGirl.create(:photo)
    end

    it "belongs to a model" do
      @m.should respond_to(:model)
    end

    it "retrieves its model" do
      @m.model.should_not be_nil
      @m.model.should be_instance_of(Model)
    end
  end
end
