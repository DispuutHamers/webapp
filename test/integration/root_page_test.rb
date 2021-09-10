require 'application_system_test_case'

class RootPageTest < ApplicationSystemTestCase
  test 'root' do
    visit root_path

    assert page.has_content?("Hamers zonder Sikkel")
    assert page.has_content?("defenestraties voorbehouden")
    assert page.has_content?("Inloggen")
    assert page.has_content?("Registreren")
  end
end
