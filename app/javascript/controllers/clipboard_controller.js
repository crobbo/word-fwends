import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["source"]

  initialize() {
    console.log("clipboard controller initialized")
  }
  
  copy() {
    navigator.clipboard.writeText(this.sourceTarget.innerText)
  }
}