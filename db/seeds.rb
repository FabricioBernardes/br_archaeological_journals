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
  },
  {
    name: "Laboratório de Ensino e Pesquisa em Antropologia e Arqueologia",
    institutional_affiliation: "Universidade Federal de Pelotas - UFPEL",
    issn: "1806-9118",
    thematic_scope: "Arqueologia e Antropologia",
    website_url: "https://periodicos.ufpel.edu.br/index.php/lepaarq",
    periodicity: "Semestral",
    current_status: "Ativa",
    foundation_year: 2004,
    closure_year: nil,
    qualis: "A2"
  }
]

scientific_journals.each do |attrs|
  ScientificJournal.find_or_create_by!(issn: attrs[:issn]) do |journal|
    journal.assign_attributes(attrs)
  end
end

lepaarq = ScientificJournal.find_by!(issn: '1806-9118')

lepaarq_editions = [
  { edition_type: 'JUL-DEC', publication_date: '2014-10-03', url: 'https://periodicos.ufpel.edu.br/index.php/lepaarq/issue/view/324', volume: 'V. 11, N. 22 (2014): JUL-DEC' },
  { edition_type: 'JAN-JUN', publication_date: '2014-03-15', url: 'https://periodicos.ufpel.edu.br/index.php/lepaarq/issue/view/279', volume: 'V. 11, N. 21 (2014): JAN-JUN' },
  { edition_type: 'JUL-DEC', publication_date: '2013-10-04', url: 'https://periodicos.ufpel.edu.br/index.php/lepaarq/issue/view/240', volume: 'V. 10, N. 20 (2013): JUL-DEC' },
  { edition_type: 'JAN-JUN', publication_date: '2013-05-06', url: 'https://periodicos.ufpel.edu.br/index.php/lepaarq/issue/view/207', volume: 'V. 10, N. 19 (2013): JAN-JUN' },
  { edition_type: 'JAN-DEC', publication_date: '2012-09-15', url: 'https://periodicos.ufpel.edu.br/index.php/lepaarq/issue/view/174', volume: 'V. 9, N. 17/18 (2012): JAN-DEC' },
  { edition_type: 'JAN-DEC', publication_date: '2011-12-06', url: 'https://periodicos.ufpel.edu.br/index.php/lepaarq/issue/view/160', volume: 'V. 8, N. 15/16 (2011): JAN-DEC' },
  { edition_type: 'JAN-DEC', publication_date: '2010-10-08', url: 'https://periodicos.ufpel.edu.br/index.php/lepaarq/issue/view/132', volume: 'V. 7, N. 13/14 (2010): JAN-DEC' },
  { edition_type: 'JAN-DEC', publication_date: '2009-11-03', url: 'https://periodicos.ufpel.edu.br/index.php/lepaarq/issue/view/82', volume: 'V. 6, N. 11/12 (2009): JAN-DEC' },
  { edition_type: 'JAN-DEC', publication_date: '2008-10-03', url: 'https://periodicos.ufpel.edu.br/index.php/lepaarq/issue/view/81', volume: 'V. 5, N. 9/10 (2008): JAN-DEC' },
  { edition_type: 'JAN-DEC', publication_date: '2007-10-03', url: 'https://periodicos.ufpel.edu.br/index.php/lepaarq/issue/view/80', volume: 'V. 4, N. 7/8 (2007): JAN-DEC' },
  { edition_type: 'JAN-DEC', publication_date: '2006-10-07', url: 'https://periodicos.ufpel.edu.br/index.php/lepaarq/issue/view/93', volume: 'V. 3, N. 5/6 (2006): JAN-DEC' },
  { edition_type: 'JUL-DEC', publication_date: '2005-10-10', url: 'https://periodicos.ufpel.edu.br/index.php/lepaarq/issue/view/79', volume: 'V. 2, N. 4 (2005): JUL-DEC' },
  { edition_type: 'JAN-JUN', publication_date: '2005-04-17', url: 'https://periodicos.ufpel.edu.br/index.php/lepaarq/issue/view/78', volume: 'V. 2, N. 3 (2005): JAN-JUN' },
  { edition_type: 'JUL-DEC', publication_date: '2004-09-24', url: 'https://periodicos.ufpel.edu.br/index.php/lepaarq/issue/view/77', volume: 'V. 1, N. 2 (2004): JUL-DEC' },
  { edition_type: 'JAN-JUN', publication_date: '2004-02-06', url: 'https://periodicos.ufpel.edu.br/index.php/lepaarq/issue/view/69', volume: 'V. 1, N. 1 (2004): JAN-JUN' }
]

lepaarq_editions.each do |attrs|
  Edition.find_or_create_by!(scientific_journal: lepaarq, volume: attrs[:volume], edition_type: attrs[:edition_type]) do |edition|
    edition.publication_date = attrs[:publication_date]
    edition.url = attrs[:url]
    edition.editors = nil
    edition.theme = nil
    edition.doi = nil
    edition.available_format = nil
  end
end

# Artigos da edição V. 11, N. 22 (2014): JUL-DEC
lepaarq_edition_2014_2 = Edition.find_by!(volume: 'V. 11, N. 22 (2014): JUL-DEC')

lepaarq_2014_2_articles = [
  {
    title: 'Editorial',
    authors: ['Rafael Guedes Milheira', 'Rosane Aparecida Rubert'],
    article_url: 'https://periodicos.ufpel.edu.br/index.php/lepaarq/article/view/4571',
    doi: nil
  },
  {
    title: 'Participações femininas na vida pública e nas atividades da Domus Romana: Testemunhos epigráficos entre Surrentum, Stabiae e Nuceria',
    authors: ['Maricí Martins Magalhães'],
    article_url: 'https://periodicos.ufpel.edu.br/index.php/lepaarq/article/view/3832',
    doi: nil
  },
  {
    title: 'Presença do blastocerus dichotomus nas pinturas rupestres do Parque Nacional Serra da Capivara e seus indicadores paleoambientais',
    authors: ['Vitor José Rampaneli Almeida'],
    article_url: 'https://periodicos.ufpel.edu.br/index.php/lepaarq/article/view/3609',
    doi: nil
  },
  {
    title: 'Problemática dos cortiços pelotenses entre os Séculos XIX e XX',
    authors: ['Letícia Nörnberg Maciel'],
    article_url: 'https://periodicos.ufpel.edu.br/index.php/lepaarq/article/view/3627',
    doi: nil
  },
  {
    title: 'Tecnología y subsistencia em el sitio arqueológico Cerro Tapera Vázquez (Parque Nacional Pre-Delta, República Argentina)',
    authors: ['Mariano Bonomo', 'Juan Carlos Castro', 'Carolina Belén Silva'],
    article_url: 'https://periodicos.ufpel.edu.br/index.php/lepaarq/article/view/3831',
    doi: nil
  },
  {
    title: 'Arqueologia do Arroio Marrecas - Caxias do Sul, RS',
    authors: ['Patricia Schneider', 'Neli Galarce Machado', 'Sidnei Wolf', 'Marcos Kreutz', 'Jones Fiegenbaum'],
    article_url: 'https://periodicos.ufpel.edu.br/index.php/lepaarq/article/view/3921',
    doi: nil
  },
  {
    title: 'Queimaram ossos na Toca do Alto do Capim',
    authors: ['Mauro Alexandre Farias Fontes', 'Lucas Braga da Silva'],
    article_url: 'https://periodicos.ufpel.edu.br/index.php/lepaarq/article/view/3905',
    doi: nil
  },
  {
    title: 'Umbuzeiro dos defuntos: Um marco na história de São Lourenço do Piauí',
    authors: ['Celito Kestering', 'Gizelle Santos de Sousa'],
    article_url: 'https://periodicos.ufpel.edu.br/index.php/lepaarq/article/view/3388',
    doi: nil
  },
  {
    title: 'Potencial informativo da coleção arqueológica do Museu Dom Avelar Brandão Vilela: Um estudo de caso a partir da série de moedas do rei Vittório Emanuele III',
    authors: ['Ana Joaquina Oliveira', 'Abrahão Sanderson Nunes Fernandes da Silva'],
    article_url: 'https://periodicos.ufpel.edu.br/index.php/lepaarq/article/view/4138',
    doi: nil
  },
  {
    title: 'Arqueoturismo no estado do Amazonas – da teoria à prática: O caso da Gruta do Batismo',
    authors: ['Margaret Cerqueira de Souza', 'Edithe Pereira'],
    article_url: 'https://periodicos.ufpel.edu.br/index.php/lepaarq/article/view/4002',
    doi: nil
  }
]

lepaarq_2014_2_articles.each do |attrs|
  author_records = attrs[:authors].map do |author_name|
    Author.find_or_create_by!(name: author_name)
  end
  Article.find_or_create_by!(title: attrs[:title], edition: lepaarq_edition_2014_2) do |article|
    article.authors = author_records
    article.article_url = attrs[:article_url]
    article.doi = attrs[:doi]
  end
end
