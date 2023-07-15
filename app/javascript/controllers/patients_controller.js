import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "popup", "button" ]
  static values = { isOpen: { type: Boolean, default: false } }

  statistics() {
    this.isOpenValue ? this.hide() : this.show()
    this.isOpenValue = !this.isOpenValue
  }

  show() {
    this.popupTarget.classList = "visible"
    this.buttonTarget.innerHTML = "Close statistics"
  }

  hide() {
    this.popupTarget.classList = "visually-hidden"
    this.buttonTarget.innerHTML = "See birth year statistics"
  }
}
