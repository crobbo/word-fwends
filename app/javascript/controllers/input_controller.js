import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["inputBox", "form"]

  connect() {
  }

  // const keys = document.querySelectorAll('.key');
  // const boardItems = document.querySelectorAll('.item-input');

  // keys.forEach((item) => {
  //     item.addEventListener('click', e => {
  //         item.innerText == 'DEL' ? backspace() : onscreenKeyboard(item.innerText)
  //     })
  // })

  virtualKey(e) {
    if (e.srcElement.innerText == 'DEL') { return this.backspace() }
    const emptyGuesses = this.inputBoxTargets.filter(item => item.value == '')
    const guesses = this.inputBoxTargets.filter(item => item.value != '')
    if (guesses.length < 5) { emptyGuesses[0].value = e.srcElement.innerText }
  }

  backspace() {
      const guesses = this.inputBoxTargets.filter(item => item.value != '')
      if (guesses.length > 0) { guesses[guesses.length - 1].value = ''}
  }
}