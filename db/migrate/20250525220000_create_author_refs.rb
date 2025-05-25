class CreateAuthorRefs < ActiveRecord::Migration[7.1]
  def change
    create_table :author_refs do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
