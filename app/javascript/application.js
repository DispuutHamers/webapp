// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "trix"
import "@rails/actiontext"
import { Application } from "@hotwired/stimulus"
import { Dropdown, Tabs, Popover } from "tailwindcss-stimulus-components"

import AlertController from "controllers/alert_controller"
import AutosaveController from "controllers/autosave_controller"
import FlatpickrController from "controllers/flatpickr_controller"
import SelectMenuController from "controllers/select_menu_controller"
import SelectTabsController from "controllers/select_tabs_controller"

const application = Application.start()

application.register("alert", AlertController)
application.register("autosave", AutosaveController)
application.register("select-menu", SelectMenuController)
application.register("select-tabs", SelectTabsController)

// Other options: Alert, Autosave, Dropdown, Modal, Popover, Toggle, Slideover
application.register("dropdown", Dropdown)
application.register("tabs", Tabs)
application.register("popover", Popover)
application.register("flatpickr", FlatpickrController)
