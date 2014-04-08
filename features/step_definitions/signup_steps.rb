Given /^a user visits the signup page$/ do
  visit signup_path
end

When /^they submit invalid signup information$/ do
  click_button "Create my account"
end

Then /^they should see an error message$/ do
  expect(page).to have_selector('div.alert.alert-error')
end

When /^the user submits valid signup information$/ do
  fill_in "Name",         with: "Example User"
  fill_in "Email",        with: "user@example.com"
  fill_in "Password",     with: "12345678"
  fill_in "Confirmation", with: "12345678"
end

Then /^it should create the user$/ do
  expect { click_button "Create my account" }.to change(User, :count).by(1)
end