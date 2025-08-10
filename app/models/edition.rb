class Edition < ApplicationRecord
  belongs_to :scientific_journal
  has_many :articles, dependent: :destroy

  validates :volume, presence: true

  def volume_with_journal
    year_part = publication_date.present? ? " (#{publication_date.year})" : ""
    "#{scientific_journal.name} - Volume #{volume}#{year_part}"
  end
end
