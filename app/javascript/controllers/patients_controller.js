import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "popup" ]
  static values = { isOpen: { type: Boolean, default: false } }

  statistics() {
    this.isOpenValue ? this.hide() : this.show()
    this.isOpenValue = !this.isOpenValue
  }

  show() {
    this.popupTarget.classList = "visible"
  }

  hide() {
    this.popupTarget.classList = "visually-hidden"
  }
}
