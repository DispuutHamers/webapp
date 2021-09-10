require 'test_helper'

class RootPageTest < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :firefox, screen_size: [1400, 1400]

  test 'root' do
    visit root_path

    assert page.has_content?("Hamers zonder Sikkel")
    assert page.has_content?("defenestraties voorbehouden")
    assert page.has_content?("Inloggen")
    assert page.has_content?("Registreren")
  end
end
