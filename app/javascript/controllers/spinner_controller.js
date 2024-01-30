import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="spinner"
export default class extends Controller {
  static targets = ['spinner']

  connect() {
    console.log("Spinner controller connected")
    this.spinnerTarget.classList.add("d-none")
    console.log("do not show spinner")
  }

  showSpinner(){
    this.spinnerTarget.classList.remove("d-none")
    console.log("show spinner")
  }
}
