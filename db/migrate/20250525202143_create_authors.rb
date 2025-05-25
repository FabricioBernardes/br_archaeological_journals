class CreateAuthors < ActiveRecord::Migration[7.1]
  def change
    create_table :authors do |t|
      t.string :name
      t.string :country_of_origin
      t.string :institutional_affiliation
      t.string :specialization_area
      t.text :academic_background

      t.timestamps
    end
  end
end
