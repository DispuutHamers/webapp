import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["option"]

  connect() {

  }

  run() {
    Turbo.visit.href = this.optionTarget.dataset.url
  }
}
