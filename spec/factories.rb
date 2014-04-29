FactoryGirl.define do
  factory :user do
    name     "Joao da Silva"
    email    "joao.da.silva@example.com"
    password "12345678"
    password_confirmation "12345678"
    reputation    0
  end
end
