# == Schema Information
#
# Table name: article_authors
#
#  id         :bigint           not null, primary key
#  article_id :bigint           not null
#  author_id  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ArticleAuthor < ApplicationRecord
  belongs_to :article
  belongs_to :author
end
