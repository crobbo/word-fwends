import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["inputBox"]

  initialize() {   
    this.index = 0
    this.focusCurrentInput()
  }

  validateInput(event) {
    const key = event.keyCode
      switch (true) {
        case key == 8: // backspace
          if(this.index > 0) { this.index -= 1 }  
          this.focusCurrentInput()
          this.clearInput()
          break
        case key == 9: // tab
          event.preventDefault()
          break
        case 64 < key && key < 91: // alphabet
          this.next(event)
          break
        default:
          this.clearInput(event)
          break
      }
  }
  
  next(event) {
    if (event.key.length == 1) {
      if(this.index < 5) { this.index += 1 }  
      this.focusCurrentInput()
    }
  }

  clearInput() {
    this.inputBoxTargets.forEach((element, index) => {
      if (index == this.index) {
        setTimeout(() => {
          element.value = ''
        }, 50)
      }
    })
  }

  focusCurrentInput() {
    this.inputBoxTargets.forEach((element, index) => {
      if (index == this.index && this.index < 5) {
        setTimeout(() => {
          element.focus()        
        }, 50)
      }
    })
  }
}