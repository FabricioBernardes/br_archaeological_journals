# == Schema Information
#
# Table name: bibliographic_references
#
#  id                   :bigint           not null, primary key
#  reference_type       :string
#  year                 :integer
#  title                :string
#  publisher            :string
#  publication_location :string
#  doi                  :string
#  language             :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
require "test_helper"

class BibliographicReferenceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
