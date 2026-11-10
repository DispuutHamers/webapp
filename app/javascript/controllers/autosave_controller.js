import { Controller } from "@hotwired/stimulus"
import { FetchRequest } from "@rails/request.js"

export default class extends Controller {
  static targets = [ "form", "status" ]

  connect() {
    this.timeout  = null
    this.duration = this.data.get("duration") || 1000
  }

  save() {
    clearTimeout(this.timeout)

    this.timeout = setTimeout(() => {
      this.statusTarget.textContent = "Saving..."
      this.submit()
    }, this.duration)
  }

  // Submit the form in the background (without a page navigation), like rails-ujs remote forms did
  async submit() {
    const form = this.formTarget
    const request = new FetchRequest(form.method, form.action, { body: new FormData(form), responseKind: "script" })

    try {
      const response = await request.perform()
      response.ok ? this.success() : this.error()
    } catch {
      this.error()
    }
  }

  success() {
    this.setStatus("Saved!")
  }

  error() {
    this.setStatus("Unable to save!")
  }

  setStatus(message) {
    this.statusTarget.textContent = message

    this.timeout = setTimeout(() => {
      this.statusTarget.textContent = ""
    }, 2000)
  }
}
