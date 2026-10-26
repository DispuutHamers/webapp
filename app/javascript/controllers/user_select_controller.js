import { Controller } from "@hotwired/stimulus"

// Searchable user picker with avatars. Enhances a native <select>, which stays
// the form field (and the fallback without JS).
export default class extends Controller {
  static targets = ["select", "widget", "button", "selectedAvatar", "selectedName", "panel", "search", "option", "empty"]

  connect() {
    this.selectTarget.classList.add("hidden")
    this.widgetTarget.classList.remove("hidden")
    this.activeIndex = -1
    this.outsideClick = (event) => {
      if (!this.element.contains(event.target)) this.close()
    }
    this.reposition = () => this.position()
    document.addEventListener("click", this.outsideClick)
    this.renderSelected()
  }

  disconnect() {
    document.removeEventListener("click", this.outsideClick)
    this.stopTracking()
  }

  toggle() {
    this.panelTarget.classList.contains("hidden") ? this.open() : this.close()
  }

  open() {
    this.panelTarget.classList.remove("hidden")
    this.buttonTarget.setAttribute("aria-expanded", "true")
    this.searchTarget.value = ""
    this.filter()
    this.searchTarget.focus()
    // Track scrolling in any container, so the fixed panel stays attached to the button
    window.addEventListener("scroll", this.reposition, true)
    window.addEventListener("resize", this.reposition)
  }

  close() {
    if (this.panelTarget.classList.contains("hidden")) return

    this.panelTarget.classList.add("hidden")
    this.buttonTarget.setAttribute("aria-expanded", "false")
    this.stopTracking()
  }

  // The panel is position: fixed so an overflow-hidden ancestor can't clip it.
  // It opens below the button, or above when there is more room there.
  position() {
    const margin = 4
    const rect = this.buttonTarget.getBoundingClientRect()
    const panel = this.panelTarget
    panel.style.left = `${rect.left}px`
    panel.style.width = `${rect.width}px`

    const spaceBelow = window.innerHeight - rect.bottom - margin
    const spaceAbove = rect.top - margin
    if (panel.offsetHeight > spaceBelow && spaceAbove > spaceBelow) {
      panel.style.top = ""
      panel.style.bottom = `${window.innerHeight - rect.top + margin}px`
    } else {
      panel.style.bottom = ""
      panel.style.top = `${rect.bottom + margin}px`
    }
  }

  stopTracking() {
    window.removeEventListener("scroll", this.reposition, true)
    window.removeEventListener("resize", this.reposition)
  }

  filter() {
    const query = this.normalize(this.searchTarget.value)
    this.optionTargets.forEach((option) => {
      option.classList.toggle("hidden", !this.normalize(option.dataset.label).includes(query))
    })
    this.emptyTarget.classList.toggle("hidden", this.visibleOptions.length > 0)
    this.setActive(0)
    this.position()
  }

  keydown(event) {
    switch (event.key) {
      case "ArrowDown":
        event.preventDefault()
        this.setActive(this.activeIndex + 1)
        break
      case "ArrowUp":
        event.preventDefault()
        this.setActive(this.activeIndex - 1)
        break
      case "Enter":
        event.preventDefault()
        if (this.visibleOptions[this.activeIndex]) this.choose(this.visibleOptions[this.activeIndex])
        break
      case "Escape":
        event.preventDefault()
        this.close()
        this.buttonTarget.focus()
        break
    }
  }

  select(event) {
    this.choose(event.currentTarget)
  }

  hover(event) {
    this.setActive(this.visibleOptions.indexOf(event.currentTarget))
  }

  choose(option) {
    this.selectTarget.value = option.dataset.value
    this.selectTarget.dispatchEvent(new Event("change", { bubbles: true }))
    this.renderSelected()
    this.close()
    this.buttonTarget.focus()
  }

  renderSelected() {
    const option = this.optionTargets.find((o) => o.dataset.value === this.selectTarget.value)
    if (!option) return

    this.selectedNameTarget.textContent = option.dataset.label
    this.selectedAvatarTarget.src = option.querySelector("img").src
    this.optionTargets.forEach((o) => o.setAttribute("aria-selected", o === option ? "true" : "false"))
  }

  setActive(index) {
    const options = this.visibleOptions
    if (options.length === 0) {
      this.activeIndex = -1
      return
    }

    this.activeIndex = Math.max(0, Math.min(index, options.length - 1))
    this.optionTargets.forEach((o) => o.classList.remove("bg-hamers-red-500", "text-white"))
    const active = options[this.activeIndex]
    active.classList.add("bg-hamers-red-500", "text-white")
    active.scrollIntoView({ block: "nearest" })
  }

  normalize(value) {
    return (value || "").toLowerCase().normalize("NFD").replace(/[̀-ͯ]/g, "")
  }

  get visibleOptions() {
    return this.optionTargets.filter((o) => !o.classList.contains("hidden"))
  }
}