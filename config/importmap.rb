# Pin npm packages by running ./bin/importmap

pin "application"
pin "flatpickr" # @4.6.13
pin "@hotwired/turbo-rails", to: "@hotwired--turbo-rails.js" # @8.0.16
pin "@hotwired/turbo", to: "@hotwired--turbo.js" # @8.0.13
pin "@rails/actioncable/src", to: "@rails--actioncable--src.js" # @8.0.201
pin "trix" # @2.1.15
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@rails/request.js", to: "@rails--request.js.js" # @0.0.12
pin "@tailwindcss/forms", to: "@tailwindcss--forms.js" # @0.5.10
pin "mini-svg-data-uri" # @1.4.4
pin "tailwindcss/colors", to: "tailwindcss--colors.js" # @4.1.12
pin "tailwindcss/defaultTheme", to: "tailwindcss--defaultTheme.js" # @4.1.12
pin "tailwindcss/plugin", to: "tailwindcss--plugin.js" # @4.1.12
pin "stimulus-flatpickr" # @1.4.0
pin "stimulus" # @3.2.2
pin "popper.js" # @1.16.1
pin "tailwindcss-stimulus-components" # @6.1.3

pin_all_from "app/javascript/controllers", under: "controllers"
