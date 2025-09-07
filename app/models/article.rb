# == Schema Information
#
# Table name: articles
#
#  id                 :bigint           not null, primary key
#  title              :string
#  abstract           :text
#  doi                :string
#  article_url        :string
#  language           :string
#  research_theme     :string
#  publication_type   :string
#  main_methodology   :string
#  institutions       :text
#  data_source        :string
#  database_citation  :text
#  states             :string
#  spatial_analysis   :boolean
#  laboratory_methods :text
#  datings            :text
#  edition_id         :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Article < ApplicationRecord
  belongs_to :edition
  has_and_belongs_to_many :keywords
  has_and_belongs_to_many :bibliographic_references

  has_many :article_authors, dependent: :destroy
  has_many :authors, through: :article_authors

  validates :title, presence: true
  validates :authors, presence: true
end
