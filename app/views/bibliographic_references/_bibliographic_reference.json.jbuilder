json.extract! bibliographic_reference, :id, :reference_type, :authors, :year, :title, :publisher, :publication_location, :doi, :language, :created_at, :updated_at
json.url bibliographic_reference_url(bibliographic_reference, format: :json)
