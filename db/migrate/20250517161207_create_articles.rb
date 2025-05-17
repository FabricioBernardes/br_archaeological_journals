class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :authors
      t.text :abstract
      t.string :doi
      t.string :article_url
      t.text :keywords
      t.string :language
      t.string :research_theme
      t.string :publication_type
      t.string :main_methodology
      t.text :bibliographic_reference
      t.text :institutions
      t.string :data_source
      t.text :database_citation
      t.string :states
      t.boolean :spatial_analysis
      t.text :laboratory_methods
      t.text :datings
      t.references :edition, null: false, foreign_key: true

      t.timestamps
    end
  end
end
