import { Controller } from "@hotwired/stimulus"
import { FetchRequest } from '@rails/request.js'

export default class extends Controller {
  static targets = ["checkbox"]

  initialize() {
  }

  async changeStatus () {
    const playerId = this.checkboxTarget.dataset.playerId
    const status = this.checkboxTarget.checked
    const request = new FetchRequest('patch', `/players/${playerId}/status`, { body: JSON.stringify({ status: status }) })
    const response = await request.perform()
    if (response.ok) {
      const body = await response.text
      // Do whatever do you want with the response body
      // You also are able to call `response.html` or `response.json`, be aware that if you call `response.json` and the response contentType isn't `application/json` there will be raised an error.
    }
  }
  
}