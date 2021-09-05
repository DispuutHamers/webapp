import { Controller } from "stimulus"

export default class extends Controller {

  connect() {
    this.animateClasses = (this.data.get('animationClass') || 'hidden').split(' ')

    if (this.data.has("autoClose")) {
      setTimeout(() => this.close(), this.data.get("autoClose"))
    }
  }

  close() {
    if (this.element) {
      this.element.classList.add(...this.animateClasses)
      setTimeout(() => this.element.remove(), 0.5 * 1000)
    }
  }
}
