# Sass is only used to compile Font Awesome (font-awesome-sass); the rest of the CSS is Tailwind.
Rails.application.config.dartsass.builds = { "fontawesome.scss" => "fontawesome.css" }

# Don't print Font Awesome's own Sass deprecation warnings on every build
Rails.application.config.dartsass.build_options << "--quiet-deps"
