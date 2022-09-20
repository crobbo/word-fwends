import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["inputBox", "form"]

  initialize() {
  }
  
  onscreenKey(e) {
    let asciiCode = this.processOnscreenKey(e)
    this.dispatch("onscreenKey", { detail: { code: asciiCode} })
  }

  processOnscreenKey(e) {
    if(e.target.innerText.toLowerCase() == 'del') {
      return 8;
    } else if (e.target.innerText.toLowerCase() == 'enter') {
      return 13;
    } else {
      return e.target.innerText.charCodeAt(0);
    }
  }

  keyPress(e) {
    e.preventDefault()
    let asciiCode = e.keyCode
    this.dispatch("keyPress", { detail: { code: asciiCode} })
  }  
}