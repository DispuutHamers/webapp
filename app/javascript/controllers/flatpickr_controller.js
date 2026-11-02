import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"

// Replaces the stimulus-flatpickr package, which doesn't work with Stimulus 3.
// Every data-flatpickr-* attribute becomes a flatpickr option, e.g.
// data-flatpickr-date-format="d-m-Y H:i" -> { dateFormat: "d-m-Y H:i" }
// data-flatpickr-time-24hr="true"        -> { time24hr: true }
export default class extends Controller {
  connect() {
    this.picker = flatpickr(this.element, this.options)
  }

  disconnect() {
    this.picker?.destroy()
  }

  get options() {
    const options = {}

    for (const { name, value } of this.element.attributes) {
      if (!name.startsWith("data-flatpickr-")) continue

      let key = name.slice("data-flatpickr-".length).replace(/-([a-z0-9])/g, (_, char) => char.toUpperCase())
      if (key === "time24hr") key = "time_24hr" // the only flatpickr option that isn't camelCase

      options[key] = value === "true" ? true : value === "false" ? false : value
    }

    return options
  }
}
