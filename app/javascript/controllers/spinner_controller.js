import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="spinner"
export default class extends Controller {
  static targets = ['spinner']

  connect() {
    console.log("Spinner controller connected")

    const params = new URLSearchParams(window.location.search)
    if (params.toString() === '') {
        this.spinnerTarget.classList.add("d-none")
    }
  }

  showSpinner(){
    this.spinnerTarget.classList.remove("d-none")
  }
}
