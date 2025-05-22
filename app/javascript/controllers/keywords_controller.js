import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["keywordTag"]

  removeKeyword(event) {
    event.preventDefault()
    console.log("removeKeyword")
    const idx = event.currentTarget.dataset.keywordsIndex
    const tag = this.keywordTagTargets.find(
      el => el.dataset.keywordsIndex === idx
    )
    if (tag) tag.remove()
    // Se precisar remover do backend, envie um request AJAX aqui.
    fetch(`/keywords/${idx}`, {
      method: "DELETE",
      headers: {
      "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
      "Accept": "application/json"
      }
    })
    .then(response => {
      if (!response.ok) {
      throw new Error(`Error: ${response.statusText}`)
      }
    })
    .catch(error => {
      console.error(error)
    })
  }
}