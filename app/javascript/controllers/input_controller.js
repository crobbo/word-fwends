import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["inputBox", "form"]

  connect() {
    this.index = 0
    this.completeGuess = false
    if(this.inputBoxTargets.length > 0) { this.focusInput(this.completeGuess)}
  }

  focusInput(completeGuess) {
    let arr = this.inputBoxTargets.filter(box => box.value != '')
    if(completeGuess) {
      arr[arr.length - 1].focus() 
    } else {
      this.inputBoxTargets.filter(box => box.value == '')[0].focus()
    }
  }

  keydown( {detail : { code }}) {
    if (code == 8 || code == 13) { this.submitOrDelete(code) 
    } else {
      if(this.index < 5 ) { this.index += 1 };
      this.addLetter(String.fromCharCode(code))
    }
  }
  
  addLetter(letter){
    letter = letter.toLowerCase() // required for ruby code to work. Don't ammend!
    if (!this.completeGuess) {
      let input = this.inputBoxTargets.filter(box => box.value == '')[0]
      if (this.index < 5) { 
        input.value = letter, this.focusInput(this.completeGuess) 
      } 
      if (this.index == 5 ) { 
        this.completeGuess = true, input.value = letter, this.focusInput(this.completeGuess)
      }
    } else {
      this.focusInput(this.completeGuess)
    }
  }

  submitOrDelete(code) {
    code == 8 ? this.deleteLetter() : this.submitForm()
  }

  deleteLetter() {
    let arr = this.inputBoxTargets.filter(box => box.value != '')
    if(this.index == 5) { this.completeGuess = false }
    if(this.index > 0) {
      this.index -= 1
      arr[arr.length - 1].value = ''
      this.focusInput(this.completeGuess)
    }
    if(this.index == 0) { this.focusInput(this.completeGuess) }
  }

  submitForm() {
    // this.formTartget.getElementsByTagName('input')
    let count = this.inputBoxTargets.filter(box => box.value != '').length
    if(count == 5){
      this.formTarget.focus()
      this.formTarget.requestSubmit()
    } else {
      this.focusInput(this.completeGuess) 
    }
  }
}