import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["select"]
  connect() {
  }

  run() {
    Turbo.visit(this.selectTarget.value)
  }
}
