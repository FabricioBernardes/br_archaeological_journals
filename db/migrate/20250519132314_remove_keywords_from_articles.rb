class RemoveKeywordsFromArticles < ActiveRecord::Migration[7.1]
  def change
    remove_column :articles, :keywords, :text
  end
end
