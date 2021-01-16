import { Controller } from "stimulus"
import ConfettiGenerator from "confetti-js";

export default class extends Controller {
  static targets = [ "canvas" ]

  start() {
    this.confetti = this.confetti();
    this.confetti.render();
  }

  stop() {
    this.confetti.clear();
    delete this.confetti;
  }

  confetti() {
    return new ConfettiGenerator({
      target: this.canvasTarget,
      size: 1.2,
      clock: 30,
      rotate: true
    });
  }
}
