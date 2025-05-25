json.extract! article, :id, :title, :abstract, :doi, :article_url, :language, :research_theme, :publication_type, :main_methodology, :institutions, :data_source,
              :database_citation, :states, :spatial_analysis, :laboratory_methods, :datings, :edition_id, :created_at, :updated_at
json.url article_url(article, format: :json)
