require 'spec_helper'

describe Image do

  let(:user) { FactoryGirl.create(:user) }
  before { @image = user.images.build(tag: "Lorem ipsum") }

  subject { @image }

  it { should respond_to(:tag) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @image.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank tag" do
    before { @image.tag = " " }
    it { should_not be_valid }
  end

  describe "with tag that is too long" do
    before { @image.tag = "a" * 31 }
    it { should_not be_valid }
  end
end