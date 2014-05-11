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

      before do
        fill_in 'image_tag', with: "Lorem ipsum"
        attach_file 'image_img', "#{Rails.root}/app/assets/images/rails.png"
      end

      it "should create an image" do
        expect { click_button "Upload" }.to change(Image, :count).by(1)
      end
    end
  end

  describe "image destruction" do
    before { FactoryGirl.create(:image, user: user) }

    describe "as correct user" do
      before { visit user_path(user) }

      it "should delete a image" do
        expect { click_link "delete" }.to change(Image, :count).by(-1)
      end
    end
  end
end