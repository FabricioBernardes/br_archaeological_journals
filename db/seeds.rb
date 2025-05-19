scientific_journals = [
  {
    name: "Revista Brasileira de Arqueologia",
    institutional_affiliation: "Sociedade de Arqueologia Brasileira",
    issn: "0102-8650",
    thematic_scope: "Arqueologia brasileira e internacional",
    website_url: "https://revista.sabnet.org/ojs/index.php/sab",
    periodicity: "Semestral",
    current_status: "Ativa",
    foundation_year: 1981,
    closure_year: nil,
    qualis: "A2"
  },
  {
    name: "Clio Arqueológica",
    institutional_affiliation: "Universidade Federal de Pernambuco",
    issn: "0102-6003",
    thematic_scope: "Arqueologia, patrimônio e história",
    website_url: "https://periodicos.ufpe.br/revistas/clioarqueologica",
    periodicity: "Semestral",
    current_status: "Ativa",
    foundation_year: 1984,
    closure_year: nil,
    qualis: "B1"
  },
  {
    name: "Boletim do Museu Paraense Emílio Goeldi. Ciências Humanas",
    institutional_affiliation: "Museu Paraense Emílio Goeldi",
    issn: "1981-8122",
    thematic_scope: "Antropologia, arqueologia, etnologia",
    website_url: "http://editora.museu-goeldi.br/humanas",
    periodicity: "Quadrimestral",
    current_status: "Ativa",
    foundation_year: 2006,
    closure_year: nil,
    qualis: "A1"
  }
]

scientific_journals.each do |attrs|
  ScientificJournal.find_or_create_by!(issn: attrs[:issn]) do |journal|
    journal.assign_attributes(attrs)
  end
end
