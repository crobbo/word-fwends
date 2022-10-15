import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["gameContent", "gameInfo"]

  initialize() {
    console.log('display controller loaded')
  }

  gameContentHeight() {
    let root = document.documentElement
    root.style.setProperty('--game-content', `${window.innerHeight * 0.8}px`)
  }

  gameInfoHeight(){
    let root = document.documentElement
    root.style.setProperty('--game-info', `${window.innerHeight * 0.2}px`)
  } 
}