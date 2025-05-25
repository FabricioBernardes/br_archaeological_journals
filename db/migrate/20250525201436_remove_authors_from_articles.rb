class RemoveAuthorsFromArticles < ActiveRecord::Migration[7.1]
  def change
    remove_column :articles, :authors, :text
  end
end
