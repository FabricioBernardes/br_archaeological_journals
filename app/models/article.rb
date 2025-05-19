class Article < ApplicationRecord
  belongs_to :edition
  has_and_belongs_to_many :keywords

  validates :title, presence: true
  validates :authors, presence: true
end
