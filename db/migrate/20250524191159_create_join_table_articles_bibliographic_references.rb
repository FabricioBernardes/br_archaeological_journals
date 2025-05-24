class CreateJoinTableArticlesBibliographicReferences < ActiveRecord::Migration[7.1]
  def change
    create_join_table :articles, :bibliographic_references do |t|
      # t.index [:article_id, :bibliographic_reference_id]
      # t.index [:bibliographic_reference_id, :article_id]
    end
  end
end
