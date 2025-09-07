# == Schema Information
#
# Table name: articles
#
#  id                 :bigint           not null, primary key
#  title              :string
#  abstract           :text
#  doi                :string
#  article_url        :string
#  language           :string
#  research_theme     :string
#  publication_type   :string
#  main_methodology   :string
#  institutions       :text
#  data_source        :string
#  database_citation  :text
#  states             :string
#  spatial_analysis   :boolean
#  laboratory_methods :text
#  datings            :text
#  edition_id         :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
