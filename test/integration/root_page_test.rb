require 'application_system_test_case'

class RootPageTest < ApplicationSystemTestCase
  test 'root' do
    visit root_path

    assert_selector "h1", text: "Hamers zonder Sikkel"
    assert_selector "h2", text: "defenestraties voorbehouden"
    assert_selector "a", text: "Inloggen"
    assert_selector "a", text: "Registreren"
  end
end
