import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["gameContent", "gameInfo", "flash", "scoreboard"]

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

  scoreboardHeight(){
    let root = document.documentElement
    root.style.setProperty('--scoreboard', `${window.innerHeight2}px`)
  } 

  showScoreboard() {
    console.log("showScoreboard")
    const scoreboard = document.querySelector(".scoreboard")
    scoreboard.classList.remove("hidden")
  }

  hideScoreboard() {
    const scoreboard = document.querySelector(".scoreboard")
    scoreboard.classList.add("hidden")
  }

  
  hide() {
    setTimeout(() => {
      this.flashTarget.classList.add("hidden")
    }, 2000);
  }
}