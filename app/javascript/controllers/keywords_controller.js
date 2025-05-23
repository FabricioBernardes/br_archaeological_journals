import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["keywordTag", "input", "suggestions"]

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
            this.addKeywordByName(value);
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
    fetch(`/keywords.json?query=${encodeURIComponent(query)}`)
      .then(r => r.json())
      .then(data => {
        this.suggestions = data;
        if (data.length === 0) {
          this.suggestionsTarget.classList.add("hidden");
          this.suggestionsTarget.innerHTML = "";
          return;
        }
        this.suggestionsTarget.innerHTML = data.map((k, i) =>
          `<li class="px-2 py-1 cursor-pointer hover:bg-blue-100" data-index="${i}">${k.name}</li>`
        ).join("");
        this.suggestionsTarget.classList.remove("hidden");
        this.selectedSuggestionIndex = -1;
      });
  }

  handleKeydown(event) {
    if (this.suggestions.length === 0) return;
    if (event.key === "ArrowDown") {
      event.preventDefault();
      this.selectedSuggestionIndex = Math.min(this.selectedSuggestionIndex + 1, this.suggestions.length - 1);
      this.updateSuggestionHighlight();
    } else if (event.key === "ArrowUp") {
      event.preventDefault();
      this.selectedSuggestionIndex = Math.max(this.selectedSuggestionIndex - 1, 0);
      this.updateSuggestionHighlight();
    } else if (event.key === "Enter") {
      event.preventDefault();
      if (this.selectedSuggestionIndex >= 0) {
        this.addKeywordFromSuggestion(this.selectedSuggestionIndex);
      } else if (this.inputTarget.value.trim() !== "") {
        this.addKeywordByName(this.inputTarget.value.trim());
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
        this.addKeywordFromSuggestion(idx);
      }
    });
  }

  addKeywordFromSuggestion(idx) {
    const keyword = this.suggestions[idx];
    this.addKeywordTag(keyword.id, keyword.name);
    this.inputTarget.value = "";
    this.suggestionsTarget.classList.add("hidden");
    this.suggestions = [];
  }

  addKeywordByName(name) {
    fetch("/keywords.json", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
        "Accept": "application/json"
      },
      body: JSON.stringify({ keyword: { name } })
    })
      .then(r => r.json())
      .then(keyword => {
        if (keyword && keyword.id) {
          this.addKeywordTag(keyword.id, keyword.name);
          this.inputTarget.value = "";
          this.suggestionsTarget.classList.add("hidden");
          this.suggestions = [];
        }
      });
  }

  addKeywordTag(id, name) {
    // Evita duplicatas
    if (this.keywordTagTargets.some(el => el.dataset.keywordsIndex == id)) return;
    const span = document.createElement("span");
    span.className = "inline-flex items-center bg-blue-100 text-blue-800 px-2 py-1 rounded";
    span.dataset.keywordsTarget = "keywordTag";
    span.dataset.keywordsIndex = id;
    span.innerHTML = `${name}
      <button type="button" class="ml-2 text-red-500 hover:text-red-700 font-bold cursor-pointer" data-action="click->keywords#removeKeyword" data-keywords-index="${id}">&times;</button>
      <input type="hidden" name="article[keyword_ids][]" value="${id}">`;
    this.inputTarget.parentNode.parentNode.insertBefore(span, this.inputTarget.parentNode);
  }

  removeKeyword(event) {
    event.preventDefault();
    const idx = event.currentTarget.dataset.keywordsIndex;
    const tag = this.keywordTagTargets.find(el => el.dataset.keywordsIndex === idx);
    if (tag) tag.remove();
  }
}