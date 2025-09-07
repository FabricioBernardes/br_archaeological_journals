# == Schema Information
#
# Table name: bibliographic_references
#
#  id                   :bigint           not null, primary key
#  reference_type       :string
#  year                 :integer
#  title                :string
#  publisher            :string
#  publication_location :string
#  doi                  :string
#  language             :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class BibliographicReference < ApplicationRecord
  has_and_belongs_to_many :articles
  has_and_belongs_to_many :author_refs

  validates :title, presence: true, uniqueness: { case_sensitive: false, message: "já existe uma referência bibliográfica com esse título" }
end
