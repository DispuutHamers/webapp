# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "trix" # @2.1.15
pin "@rails/actiontext", to: "actiontext.esm.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "@rails/request.js", to: "@rails--request.js.js" # @0.0.12
pin "tailwindcss-stimulus-components" # @6.1.3

pin_all_from "app/javascript/controllers", under: "controllers"
