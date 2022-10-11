import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["source"]

  initialize() {
  }
  
  copy() {
    navigator.clipboard.writeText(this.sourceTarget.innerText)
  }
}