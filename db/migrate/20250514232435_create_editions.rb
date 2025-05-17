class CreateEditions < ActiveRecord::Migration[7.1]
  def change
    create_table :editions do |t|
      t.string :volume
      t.date :publication_date
      t.text :editors
      t.string :theme
      t.string :edition_type
      t.string :url
      t.string :doi
      t.string :available_format
      t.references :scientific_journal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
