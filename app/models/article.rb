class Article < ApplicationRecord
  belongs_to :edition
  has_and_belongs_to_many :keywords
  has_and_belongs_to_many :bibliographic_references

  validates :title, presence: true
  validates :authors, presence: true
end
