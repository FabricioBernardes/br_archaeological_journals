class Article < ApplicationRecord
  belongs_to :edition

  validates :title, presence: true
  validates :authors, presence: true
end
