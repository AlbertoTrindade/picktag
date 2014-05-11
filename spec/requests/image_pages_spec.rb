require 'spec_helper'

describe "Image pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "image creation" do
    before { visit upload_path }

    describe "with invalid information" do

      it "should not create an image" do
        expect { click_button "Upload" }.not_to change(Image, :count)
      end

      describe "error messages" do
        before { click_button "Upload" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'image_tag', with: "Lorem ipsum" }
      it "should create an image" do
        expect { click_button "Upload" }.to change(Image, :count).by(1)
      end
    end
  end
end