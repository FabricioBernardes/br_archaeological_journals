class Edition < ApplicationRecord
  belongs_to :scientific_journal
  has_many :articles, dependent: :destroy

  validates :volume, presence: true

  def volume_with_journal
    "#{scientific_journal.name} - Volume #{volume} (#{publication_date.year})"
  end
end
