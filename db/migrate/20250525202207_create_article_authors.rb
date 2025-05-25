class CreateArticleAuthors < ActiveRecord::Migration[7.1]
  def change
    create_table :article_authors do |t|
      t.references :article, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
