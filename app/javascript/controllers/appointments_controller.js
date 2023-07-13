import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
  static targets = [ "doctor", "timeslots" ]

  doctorChange() {
    get(`/appointments/doctor_time_slots?doctor_id=${this.doctor}&target=${this.target}`, {
      responseKind: "turbo-stream"
    })
  }

  get doctor() {
    return this.doctorTarget.value
  }

  get target() {
    return this.timeslotsTarget.id
  }
}
