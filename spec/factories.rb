FactoryGirl.define do
  factory :user do
    name     "Joao da Silva"
    email    "joao.da.silva@example.com"
    password "12345678"
    password_confirmation "12345678"
    reputation    0
  end

  factory :image do
    tag "Lorem ipsum"
    img File.new("#{Rails.root}/app/assets/images/rails.png")
    rating 0
    user
  end

  factory :feedback do
    relevant true
    user
    image
  end
end
