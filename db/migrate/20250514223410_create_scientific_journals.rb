class CreateScientificJournals < ActiveRecord::Migration[7.1]
  def change
    create_table :scientific_journals do |t|
      t.string :name
      t.string :institutional_affiliation
      t.string :issn
      t.text :thematic_scope
      t.string :website_url
      t.string :periodicity
      t.string :current_status
      t.integer :foundation_year
      t.integer :closure_year
      t.string :qualis

      t.timestamps
    end
  end
end
