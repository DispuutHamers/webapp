import { Controller } from "stimulus"
import ConfettiGenerator from "confetti-js";

export default class extends Controller {
  static targets = [ "canvas" ]

  start() {    
    if (typeof this.confetti === 'undefined') {
      var confettiSettings = {
        target: this.canvasTarget,
        size: 1.2,
        clock: 30,
        rotate: true,
        props: [{ "type": "svg", "src": "/assets/hamers.svg" }]
      };
      this.confetti = new ConfettiGenerator(confettiSettings);
    }
    console.log('Starting render');
    this.confetti.render();
    console.log('Stopping render');
  }
  
  stop() {
    this.confetti.clear();
    this.confetti = undefined;
  }
}
