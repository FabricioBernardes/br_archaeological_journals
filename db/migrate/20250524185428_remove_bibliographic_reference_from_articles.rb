class RemoveBibliographicReferenceFromArticles < ActiveRecord::Migration[7.1]
  def change
    remove_column :articles, :bibliographic_reference, :text
  end
end
