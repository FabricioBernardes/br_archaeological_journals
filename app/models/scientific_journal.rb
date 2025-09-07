# == Schema Information
#
# Table name: scientific_journals
#
#  id                        :bigint           not null, primary key
#  name                      :string
#  institutional_affiliation :string
#  issn                      :string
#  thematic_scope            :text
#  website_url               :string
#  periodicity               :string
#  current_status            :string
#  foundation_year           :integer
#  closure_year              :integer
#  qualis                    :string
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
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
