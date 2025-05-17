class Edition < ApplicationRecord
  belongs_to :scientific_journal

  validates :volume, presence: true
end
