class ScientificJournal < ApplicationRecord
  has_many :editions, dependent: :destroy
end
