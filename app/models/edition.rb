# == Schema Information
#
# Table name: editions
#
#  id                    :bigint           not null, primary key
#  volume                :string
#  publication_date      :date
#  editors               :text
#  theme                 :string
#  edition_type          :string
#  url                   :string
#  doi                   :string
#  available_format      :string
#  scientific_journal_id :bigint           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class Edition < ApplicationRecord
  belongs_to :scientific_journal
  has_many :articles, dependent: :destroy

  validates :volume, presence: true

  def volume_with_journal
    year_part = publication_date.present? ? " (#{publication_date.year})" : ""
    "#{scientific_journal.name} - Volume #{volume}#{year_part}"
  end
end
