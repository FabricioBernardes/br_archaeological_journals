class CreateJoinTableArticlesKeywords < ActiveRecord::Migration[7.1]
  def change
    create_join_table :articles, :keywords do |t|
      t.index [:article_id, :keyword_id]
      t.index [:keyword_id, :article_id]
    end
  end
end
