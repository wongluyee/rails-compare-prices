import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notice"
export default class extends Controller {
  static targets = ["noticeElement"]

  fire() {
    this.noticeElementTarget.classList.toggle("d-none")
  }
}
