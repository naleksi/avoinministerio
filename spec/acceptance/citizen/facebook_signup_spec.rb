# -*- encoding: utf-8 -*-
require "acceptance/acceptance_helper"

feature "New citizen logins in with Facebook and creates new account" do
  background do
    mock_facebook_omniauth("654321", { email: "citizen-kane@example.com", first_name: "Kane City", last_name: "Citizen"})
  end

  scenario "Create user through Facebook login" do
    visit homepage
    click_link "Kirjaudu Facebookilla"
    # This triggers a meta refresh. Capybara doesn't appear to support it,
    # so let's go to the target path manually.
    visit citizen_register_with_facebook_path

    should_be_on homepage
    Citizen.where(email: 'citizen-kane@example.com').count.should == 1
  end
end