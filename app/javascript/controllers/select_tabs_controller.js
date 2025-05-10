import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['tab', 'panel']

  connect() {
    this.index = 0
    this.showTab()
  }

  change(event) {
    event.preventDefault()
    this.index = event.currentTarget.value

    window.dispatchEvent(new CustomEvent('tsc:tab-change'))
  }

  showTab() {
    this.panelTargets.forEach((_, index) => {
      const panel = this.panelTargets[index]

      if (index === this.index) {
        panel.classList.remove('hidden')
      } else {
        panel.classList.add('hidden')
      }
    })
  }

  get index() {
    return parseInt(this.data.get('index') || 0)
  }

  set index(value) {
    this.data.set('index', (value >= 0 ? value : 0))
    this.showTab()
  }
}
