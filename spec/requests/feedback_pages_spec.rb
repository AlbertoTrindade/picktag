require 'spec_helper'

describe "Feedback pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "give feedback" do
  	let(:another_user) { FactoryGirl.create(:user, email: "anotheremail@example.com") }
    let(:one_more_user) { FactoryGirl.create(:user, email: "onemoreuser@example.com") }
    let!(:img1) { FactoryGirl.create(:image, user: another_user, tag: "img1",
                                      img: File.new("#{Rails.root}/app/assets/images/rails.png"),
                                      rating: 0)  } 
    let!(:img2) { FactoryGirl.create(:image, user: another_user, tag: "img2",
                                      img: File.new("#{Rails.root}/app/assets/images/rails.png"),
                                      rating: 10)  }
    let!(:feedback) { FactoryGirl.create(:feedback, relevant: true, user: one_more_user, image: img2) }

    before { visit root_path }

    describe "relevant feedback" do
      before do
        fill_in "tag", with: "img1"
        click_button "Search images"
        click_button "Yes"
      end

      it { should have_content("Rating: 10.0") }

      before { visit user_path(another_user) }		
      it { should have_content("Reputation: 10.0") }
    end

    before { visit root_path }

    describe "irrelevant feedback" do
      before do
        fill_in "tag", with: "img2"
        click_button "Search images"
        click_button "No"
      end

      it { should have_content("Rating: 5.0") }

      before { visit user_path(another_user) }
      it { should have_content("Reputation: 5.0") }
    end
  end
end