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

  describe "search page" do
    let!(:img1) { FactoryGirl.create(:image, user: user, tag: "img1",
                                      img: File.new("#{Rails.root}/app/assets/images/rails.png"),
                                      rating: 0)  }
    let!(:img2) { FactoryGirl.create(:image, user: user, tag: "img2",
                                      img: File.new("#{Rails.root}/app/assets/images/rails.png"),
                                      rating: 0)  }

    before do
      sign_in user
      visit root_path
    end

    describe "search results" do
      before do
        fill_in "tag", with: "img2"
        click_button "Search images"
      end

      it { should have_title("Search results") }
      it { should have_content(img2.tag) }
      it { should_not have_content(img1.tag) }
    end
  end

  describe "show image page" do
    let!(:img) { FactoryGirl.create(:image, user: user, tag: "img",
                                      img: File.new("#{Rails.root}/app/assets/images/rails.png"),
                                      rating: 0)  }

    before do
      sign_in user
      visit image_path(img)
    end

    it { should have_title(img.tag) }
    it { should have_content(img.tag) }
    it { should have_content(user.name) }
  end
end