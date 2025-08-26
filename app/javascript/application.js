// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "controllers"
import Rails from '@rails/ujs';
import 'core-js/stable'
import 'regenerator-runtime/runtime'
import "@hotwired/turbo-rails"
import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers"
import '@fortawesome/fontawesome-free/js/all'
import 'trix'
import 'trix/dist/trix.css'
import '@rails/actiontext'
import "../stylesheets/application.css"
import * as ActiveStorage from "@rails/activestorage"
import Flatpickr from 'stimulus-flatpickr'

ActiveStorage.start()
Rails.start();

const application = Application.start()
const context = require.context("../controllers", true, /\.js$/)
application.load(definitionsFromContext(context))

// Other options: Alert, Autosave, Dropdown, Modal, Popover, Toggle, Slideover
import { Dropdown, Tabs, Popover } from "tailwindcss-stimulus-components"
application.register('dropdown', Dropdown)
application.register('tabs', Tabs)
application.register('popover', Popover)
application.register('flatpickr', Flatpickr)
