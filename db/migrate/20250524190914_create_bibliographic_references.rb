class CreateBibliographicReferences < ActiveRecord::Migration[7.1]
  def change
    create_table :bibliographic_references do |t|
      t.string :reference_type
      t.text :authors
      t.integer :year
      t.string :title
      t.string :publisher
      t.string :publication_location
      t.string :doi
      t.string :language

      t.timestamps
    end
  end
end
