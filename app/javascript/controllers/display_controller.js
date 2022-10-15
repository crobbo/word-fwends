import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["gameContent", "gameInfo", "flash"]

  initialize() {
  }

  gameContentHeight() {
    let root = document.documentElement
    root.style.setProperty('--game-content', `${window.innerHeight * 0.8}px`)
  }

  gameInfoHeight(){
    let root = document.documentElement
    root.style.setProperty('--game-info', `${window.innerHeight * 0.2}px`)
  } 

  hide() {
    setTimeout(() => {
      this.flashTarget.classList.add("hidden")
    }, 2000);
  }
}