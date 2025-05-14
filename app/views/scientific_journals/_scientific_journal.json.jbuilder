json.extract! scientific_journal, :id, :name, :institutional_affiliation, :issn, :thematic_scope, :website_url, :periodicity, :current_status, :foundation_year, :closure_year, :qualis, :created_at, :updated_at
json.url scientific_journal_url(scientific_journal, format: :json)
