# Pin npm packages by running ./bin/importmap

pin "application"
pin "flatpickr" # @4.6.13
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "trix" # @2.1.15
pin "@rails/actiontext", to: "actiontext.esm.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "@rails/request.js", to: "@rails--request.js.js" # @0.0.12
pin "@tailwindcss/forms", to: "@tailwindcss--forms.js" # @0.5.10
pin "mini-svg-data-uri" # @1.4.4
pin "tailwindcss/colors", to: "tailwindcss--colors.js" # @4.1.12
pin "tailwindcss/defaultTheme", to: "tailwindcss--defaultTheme.js" # @4.1.12
pin "tailwindcss/plugin", to: "tailwindcss--plugin.js" # @4.1.12
pin "popper.js" # @1.16.1
pin "tailwindcss-stimulus-components" # @6.1.3

pin_all_from "app/javascript/controllers", under: "controllers"
