import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["inputBox", "form"]

  initialize() {
    this.index = 0
    this.focusCurrentInput()
  }

  validateInput(event) {
    const key = event.keyCode
    console.log(key)
    console.log(this.index)
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
      if(this.index < 4) { this.index += 1 }
      this.focusCurrentInput()
    }
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

  clearInput() {
    this.inputBoxTargets.forEach((element, index) => {
      if (index == this.index) {
        setTimeout(() => {
          element.value = ''
        }, 50)
      }
    })
  }

  onscreenKey(event) {
    let keyEvent = this.processOnscreenKey(event)

    this.inputBoxTargets.forEach((element, index) =>{
      if (index == this.index) {
        if (64 < keyEvent.keyCode && keyEvent.keyCode < 91) {
          element.value = keyEvent.key
        }
      }
    })

    this.validateInput(keyEvent)
  }

  processOnscreenKey(event) {
    let keyEvent = { key: event.target.innerText, keyCode: event.target.innerText.charCodeAt(0) } 
    if (keyEvent.key == 'Enter') { keyEvent.keyCode = 13; this.submitForm() }  
    if (keyEvent.key == 'Del')  keyEvent.keyCode = 8 
    return keyEvent
  }

  submitForm() {
    this.formTargets[0].focus()
    this.formTargets[0].requestSubmit()
  }
}