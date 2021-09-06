import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["option"]

  connect() {

  }

  run() {
    window.location.href = this.optionTarget.dataset.url
  }
}
