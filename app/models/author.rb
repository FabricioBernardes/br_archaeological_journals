# == Schema Information
#
# Table name: authors
#
#  id                        :bigint           not null, primary key
#  name                      :string
#  country_of_origin         :string
#  institutional_affiliation :string
#  specialization_area       :string
#  academic_background       :text
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
class Author < ApplicationRecord
  has_many :article_authors, dependent: :destroy
  has_many :articles, through: :article_authors
end
