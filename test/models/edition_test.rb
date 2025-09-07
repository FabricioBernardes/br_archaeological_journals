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
require "test_helper"

class EditionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
