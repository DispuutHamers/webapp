require 'application_system_test_case'

class RootPageTest < ApplicationSystemTestCase
  test 'root' do
    visit root_path

    assert_selector "h1", text: "Hamers zonder Sikkel"
    assert_selector "p", text: "defenestraties voorbehouden"
    assert_selector "a", text: "Log in"
    assert_selector "a", text: "Registreer"
  end
end
