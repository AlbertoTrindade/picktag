require 'spec_helper'

describe Feedback do

  let(:user) { FactoryGirl.create(:user) }
  let!(:image) { FactoryGirl.create(:image, user: user, tag: "img1",
                                      img: File.new("#{Rails.root}/app/assets/images/rails.png"),
                                      rating: 0)  }

  before { @feedback = user.feedbacks.build(relevant: true, image_id: image.id) }

  subject { @feedback }

  it { should respond_to(:relevant) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:image_id) }
  it { should respond_to(:image) }

  it { should be_valid }

end
