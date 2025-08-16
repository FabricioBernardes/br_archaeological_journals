import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "doiInput",
    "referenceType", 
    "year", 
    "title", 
    "publisher", 
    "publicationLocation", 
    "language",
    "authorsContainer",
    "message",
    "doiField"
  ]

  connect() {
    console.log("DOI lookup controller connected")
  }

  fetchDoi() {
    const doiValue = this.doiInputTarget.value.trim()
    
    if (!doiValue) {
      this.showMessage("Por favor, forneça um DOI válido", "error")
      return
    }
    
    this.showMessage("Buscando informações do DOI...", "info")
    
    fetch(`/bibliographic_references/fetch_doi?doi=${encodeURIComponent(doiValue)}`)
      .then(response => {
        if (!response.ok) {
          return response.json().then(data => {
            throw new Error(data.error || 'DOI não encontrado ou inválido')
          })
        }
        return response.json()
      })
      .then(data => {
        this.populateFields(data)
        this.showMessage("Informações carregadas com sucesso!", "success")
      })
      .catch(error => {
        this.showMessage(`Erro: ${error.message}`, "error")
        console.error("Error fetching DOI:", error)
      })
  }

  populateFields(data) {
    if (data.title) this.titleTarget.value = data.title
    if (data.reference_type) this.referenceTypeTarget.value = data.reference_type
    if (data.year) this.yearTarget.value = data.year
    if (data.publisher) this.publisherTarget.value = data.publisher
    if (data.publication_location) this.publicationLocationTarget.value = data.publication_location
    if (data.language) this.languageTarget.value = data.language
    
    // Preencher o campo DOI se ele existe
    if (this.hasDoiFieldTarget && data.doi) {
      this.doiFieldTarget.value = data.doi
    }
    
    // Handle authors if available
    if (data.authors && data.authors.length > 0) {
      this.displayAuthors(data.authors)
    }
  }
  
  displayAuthors(authors) {
    // Verifica se estamos no formulário de artigos ou de referências bibliográficas
    const isArticleForm = window.location.pathname.includes('articles')
    const namePrefix = isArticleForm ? 'new_bibliographic_reference[author_names][]' : 'bibliographic_reference[author_names][]'
    
    const authorsHtml = authors.map((author, index) => `
      <div class="mb-2 p-2 border rounded bg-gray-50 flex items-center justify-between">
        <span>${author}</span>
        <input type="hidden" name="${namePrefix}" value="${author}">
      </div>
    `).join('')
    
    this.authorsContainerTarget.innerHTML = `
      <div class="text-sm mb-2">
        ${authors.length} autor(es) encontrado(s):
      </div>
      ${authorsHtml}
      <div class="text-sm text-gray-500 mt-2">
        Estes autores serão criados automaticamente caso não existam.
      </div>
    `
  }
  
  showMessage(text, type) {
    const messageEl = this.messageTarget
    messageEl.textContent = text
    messageEl.classList.remove("hidden", "text-red-500", "text-green-500", "text-blue-500")
    
    switch (type) {
      case "error":
        messageEl.classList.add("text-red-500")
        break
      case "success":
        messageEl.classList.add("text-green-500")
        break
      case "info":
        messageEl.classList.add("text-blue-500")
        break
    }
  }
}
