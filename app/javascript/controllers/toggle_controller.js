import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "toggle" ]
  
  enable() {
    this.toggleTarget.checked = true;
  }
  
  disable() {
    this.toggleTarget.checked = false;
  }
}
