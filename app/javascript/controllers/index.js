// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Controllers from tailwindcss-stimulus-components
// Other options: Alert, Autosave, ColorPreview, Modal, Slideover, Toggle
import { Dropdown, Tabs, Popover } from "tailwindcss-stimulus-components"
application.register("dropdown", Dropdown)
application.register("tabs", Tabs)
application.register("popover", Popover)
