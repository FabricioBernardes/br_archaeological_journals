# string :name
# string :institutional_affiliation
# string :issn
# text :thematic_scope
# string :website_url
# string :periodicity
# string :current_status
# integer :foundation_year
# integer :closure_year
# string :qualis

class ScientificJournal < ApplicationRecord
  has_many :editions, dependent: :destroy

  def articles_count
    Article.joins(:edition).where(editions: { scientific_journal_id: id }).count
  end
end
