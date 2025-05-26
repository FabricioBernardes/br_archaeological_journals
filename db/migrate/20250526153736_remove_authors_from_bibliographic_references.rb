class RemoveAuthorsFromBibliographicReferences < ActiveRecord::Migration[7.1]
  def change
    remove_column :bibliographic_references, :authors, :text
  end
end
