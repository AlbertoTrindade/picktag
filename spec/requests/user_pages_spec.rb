require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "12345678"
        fill_in "Confirmation", with: "12345678"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:img1) { FactoryGirl.create(:image, user: user, tag: "img1",
                                      img: File.new("#{Rails.root}/app/assets/images/rails.png"),
                                      rating: 0)  }
    let!(:img2) { FactoryGirl.create(:image, user: user, tag: "img2",
                                      img: File.new("#{Rails.root}/app/assets/images/rails.png"),
                                      rating: 0)  }

    before do
      sign_in user
      visit user_path(user)
    end

    it { should have_content(user.name) }
    it { should have_content(user.email) }
    it { should have_content(user.reputation) }
    it { should have_title(user.name) }

    describe "images" do
      it { should have_content(img1.tag) }
      it { should have_content(img2.tag) }
      it { should have_content(user.images.count) }
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("Update your information") }
      it { should have_title("Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "New User Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirmation", with: user.password
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(user.reload.name).to  eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end

  end

end
