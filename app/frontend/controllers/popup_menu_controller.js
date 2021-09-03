import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "menu" ]
  static values = { invisible: Boolean }

  connect() {

  }

  toggle(event) {
    event.preventDefault()
    this.run()
  }

  hide() {
    this.menuTarget.classList.toggle('opacity-0')
    this.menuTarget.classList.toggle('hidden')
  }

  run() {
    this.invisibleValue = !this.invisibleValue
    if (this.invisibleValue) {
      this.hide();
    } else {
      this.hide();
    }
  }

  close(event) {
    if (this.element.contains(event.target) === false && this.invisibleValue === true) {
      this.run();
    }
  }
}
