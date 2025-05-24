import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["referenceTag", "input", "suggestions"]

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
            this.addReferenceByTitle(value);
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
    fetch(`/bibliographic_references.json?query=${encodeURIComponent(query)}`)
      .then(r => r.json())
      .then(data => {
        this.suggestions = data;
        if (data.length === 0) {
          this.suggestionsTarget.classList.add("hidden");
          this.suggestionsTarget.innerHTML = "";
          return;
        }
        this.suggestionsTarget.innerHTML = data.map((ref, i) =>
          `<li class='px-2 py-1 cursor-pointer hover:bg-green-100' data-index='${i}'>${ref.title}</li>`
        ).join("");
        this.suggestionsTarget.classList.remove("hidden");
        this.selectedSuggestionIndex = -1;
        // Adiciona event listener para clique nas sugestões
        this.suggestionsTarget.querySelectorAll('li').forEach(li => {
          li.addEventListener('click', (e) => {
            const idx = parseInt(li.getAttribute('data-index'));
            this.addReferenceFromSuggestion(idx);
            this.inputTarget.value = "";
            this.suggestionsTarget.classList.add("hidden");
            this.suggestionsTarget.innerHTML = "";
          });
        });
      });
  }

  handleKeydown(event) {
    if (event.key === "Enter") {
      event.preventDefault();
      if (this.suggestions && this.suggestions.length > 0 && this.selectedSuggestionIndex >= 0) {
        this.addReferenceFromSuggestion(this.selectedSuggestionIndex);
      } else if (this.inputTarget.value.trim() !== "") {
        this.addReferenceByTitle(this.inputTarget.value.trim());
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
    const items = this.suggestionsTarget.querySelectorAll("li");
    items.forEach((el, i) => {
      el.classList.toggle("bg-green-200", i === this.selectedSuggestionIndex);
    });
  }

  addReferenceFromSuggestion(index) {
    const ref = this.suggestions[index];
    if (ref) {
      this.addReference(ref);
      this.inputTarget.value = "";
      this.suggestionsTarget.classList.add("hidden");
      this.suggestionsTarget.innerHTML = "";
    }
  }

  addReferenceByTitle(title) {
    fetch(`/bibliographic_references.json?query=${encodeURIComponent(title)}`)
      .then(r => r.json())
      .then(data => {
        if (data.length > 0) {
          this.addReference(data[0]);
        } else {
          alert("Referência não encontrada. Cadastre-a primeiro.");
        }
        this.inputTarget.value = "";
        this.suggestionsTarget.classList.add("hidden");
        this.suggestionsTarget.innerHTML = "";
      });
  }

  addReference(ref) {
    // Prevent duplicates
    if (this.element.querySelector(`input[name='article[bibliographic_reference_ids][]'][value='${ref.id}']`)) {
      return;
    }
    const tag = document.createElement("span");
    tag.className = "inline-flex items-center bg-green-100 text-green-800 px-2 py-1 rounded mr-2 mb-2";
    tag.innerHTML = `
      ${ref.title}
      <button type='button' class='ml-2 text-red-500 hover:text-red-700 font-bold cursor-pointer' data-action='click->bibliographic-references#removeReference' data-bibliographic-references-index='${ref.id}'>&times;</button>
      <input type='hidden' name='article[bibliographic_reference_ids][]' value='${ref.id}'>
    `;
    this.inputTarget.parentNode.parentNode.querySelector(".flex.flex-wrap").appendChild(tag);
  }

  removeReference(event) {
    const btn = event.target;
    const tag = btn.closest("span");
    if (tag) tag.remove();
  }
}
