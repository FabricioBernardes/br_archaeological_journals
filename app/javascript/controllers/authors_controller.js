import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["authorTag", "input", "suggestions"]

  connect() {
    this.selectedSuggestionIndex = -1;
    this.suggestions = [];
    if (this.hasInputTarget) {
      const addButton = this.inputTarget.parentNode.querySelector('button[type="button"]');
      if (addButton) {
        addButton.addEventListener('click', (e) => {
          e.preventDefault();
          const value = this.inputTarget.value.trim();
          if (value) {
            this.addAuthorByName(value);
          }
        });
      }
    }
  }

  autocomplete(event) {
    const query = this.inputTarget.value.trim();
    if (query.length < 2) {
      this.suggestionsTarget.classList.add("hidden");
      this.suggestionsTarget.innerHTML = "";
      return;
    }
    fetch(`/authors.json?query=${encodeURIComponent(query)}`)
      .then(r => r.json())
      .then(data => {
        this.suggestions = data;
        if (data.length === 0) {
          this.suggestionsTarget.classList.add("hidden");
          this.suggestionsTarget.innerHTML = "";
          return;
        }
        this.suggestionsTarget.innerHTML = data.map((a, i) =>
          `<li class="px-2 py-1 cursor-pointer hover:bg-blue-100" data-index="${i}">${a.name}</li>`
        ).join("");
        this.suggestionsTarget.classList.remove("hidden");
        this.selectedSuggestionIndex = -1;
      });
  }

  handleKeydown(event) {
    if (event.key === "Enter") {
      event.preventDefault();
      if (this.suggestions && this.suggestions.length > 0 && this.selectedSuggestionIndex >= 0) {
        this.addAuthorFromSuggestion(this.selectedSuggestionIndex);
      } else if (this.inputTarget.value.trim() !== "") {
        this.addAuthorByName(this.inputTarget.value.trim());
      }
    } else if (this.suggestions && this.suggestions.length > 0) {
      if (event.key === "ArrowDown") {
        event.preventDefault();
        this.selectedSuggestionIndex = Math.min(this.selectedSuggestionIndex + 1, this.suggestions.length - 1);
        this.updateSuggestionHighlight();
      } else if (event.key === "ArrowUp") {
        event.preventDefault();
        this.selectedSuggestionIndex = Math.max(this.selectedSuggestionIndex - 1, 0);
        this.updateSuggestionHighlight();
      }
    }
  }

  updateSuggestionHighlight() {
    Array.from(this.suggestionsTarget.children).forEach((li, i) => {
      li.classList.toggle("bg-blue-100", i === this.selectedSuggestionIndex);
    });
  }

  suggestionsTargetConnected(element) {
    element.addEventListener("mousedown", (e) => {
      if (e.target.tagName === "LI") {
        const idx = parseInt(e.target.dataset.index, 10);
        this.addAuthorFromSuggestion(idx);
      }
    });
  }

  addAuthorFromSuggestion(idx) {
    const author = this.suggestions[idx];
    this.addAuthorTag(author.id, author.name);
    this.inputTarget.value = "";
    this.suggestionsTarget.classList.add("hidden");
    this.suggestions = [];
  }

  addAuthorByName(name) {
    fetch("/authors.json", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
        "Accept": "application/json"
      },
      body: JSON.stringify({ author: { name } })
    })
      .then(r => r.json())
      .then(author => {
        if (author && author.id) {
          this.addAuthorTag(author.id, author.name);
          this.inputTarget.value = "";
          this.suggestionsTarget.classList.add("hidden");
          this.suggestions = [];
        }
      });
  }

  addAuthorTag(id, name) {
    // Evita duplicatas
    if (this.authorTagTargets.some(el => el.dataset.authorsIndex == id)) return;
    const span = document.createElement("span");
    span.className = "inline-flex items-center bg-blue-100 text-blue-800 px-2 py-1 rounded";
    span.dataset.authorsTarget = "authorTag";
    span.dataset.authorsIndex = id;
    span.innerHTML = `${name}
      <button type="button" class="ml-2 text-red-500 hover:text-red-700 font-bold cursor-pointer" data-action="click->authors#removeAuthor" data-authors-index="${id}">&times;</button>
      <input type="hidden" name="article[author_ids][]" value="${id}">`;
    // Encontra o container correto das tags existentes
    const container = this.inputTarget.closest('.flex.flex-col').querySelector('.flex.flex-wrap');
    if (container) {
      container.appendChild(span);
    } else {
      // fallback antigo
      this.inputTarget.parentNode.parentNode.insertBefore(span, this.inputTarget.parentNode);
    }
  }

  removeAuthor(event) {
    event.preventDefault();
    const idx = event.currentTarget.dataset.authorsIndex;
    const tag = this.authorTagTargets.find(el => el.dataset.authorsIndex === idx);
    if (tag) tag.remove();
  }
}
