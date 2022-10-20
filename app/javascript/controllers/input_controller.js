import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["inputBox", "form"]

  connect() {
  }

  virtualKey(e) {
    this.keyAnimation(e.target);
    const emptyGuesses = this.inputBoxTargets.filter(item => item.value == '')
    const guesses = this.inputBoxTargets.filter(item => item.value != '')
    if (e.srcElement.innerText == 'DEL') { return this.backspace() }
    if (e.srcElement.innerText == 'ENTER' && guesses.length == 5 ) { return this.formTarget.requestSubmit() }
    if (guesses.length < 5 && e.srcElement.innerText != 'ENTER' ) { emptyGuesses[0].value = e.srcElement.innerText.toLowerCase() }
  }

  keyAnimation(key) {
    key.classList.add('w-16', 'h-16', 'bg-gray-200', 'text-gray-800')
    setTimeout(function(){ key.classList.remove('w-16', 'h-16', 'bg-gray-200','text-gray-800'); }, 100);
  }

  hardwareKey(e) {
    const emptyGuesses = this.inputBoxTargets.filter(item => item.value == '')
    const guesses = this.inputBoxTargets.filter(item => item.value != '')
    if ((64 < e.keyCode && e.keyCode < 91) && guesses.length < 5 ) {
      emptyGuesses[0].value = e.key
    }
    if (e.keyCode == 8) { return this.backspace() }
    if (e.keyCode == 13 && guesses.length == 5 ) { return this.formTarget.requestSubmit() }
  }

  backspace() {
      const guesses = this.inputBoxTargets.filter(item => item.value != '')
      if (guesses.length > 0) { guesses[guesses.length - 1].value = ''}
  }
}