# == Schema Information
#
# Table name: bibliographic_references
#
#  reference_type        :string   # Tipo de referência bibliográfica (ex: livro, artigo, etc.)
#  authors               :text     # Lista de autores da referência
#  year                  :integer  # Ano de publicação
#  title                 :string   # Título da referência
#  publisher             :string   # Editora ou instituição responsável pela publicação
#  publication_location  :string   # Local de publicação
#  doi                   :string   # DOI (Digital Object Identifier) da referência
#  language              :string   # Idioma da referência
#  created_at            :datetime # Data de criação do registro
#  updated_at            :datetime # Data de atualização do registro

class BibliographicReference < ApplicationRecord
  has_and_belongs_to_many :articles
  has_and_belongs_to_many :author_refs

  validates :title, presence: true, uniqueness: { case_sensitive: false, message: "já existe uma referência bibliográfica com esse título" }
end
