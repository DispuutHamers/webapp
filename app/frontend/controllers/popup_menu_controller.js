import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "menu" ]
  static values = { invisible: Boolean }

  connect() {
    this.run()
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
    let state = []
    if (this.invisibleValue) {
      state.push('dropOut', 'speed-200')
    } else {
      this.hide()
      state.push('dropIn', 'speed-200')
    }
  }

  clickedAway(event) {
    if (this.element.contains(event.target) === false && this.invisibleValue === false) {
      this.run()
    }
  }
}
