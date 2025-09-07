# == Schema Information
#
# Table name: scientific_journals
#
#  id                        :bigint           not null, primary key
#  name                      :string
#  institutional_affiliation :string
#  issn                      :string
#  thematic_scope            :text
#  website_url               :string
#  periodicity               :string
#  current_status            :string
#  foundation_year           :integer
#  closure_year              :integer
#  qualis                    :string
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
require "test_helper"

class ScientificJournalTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
