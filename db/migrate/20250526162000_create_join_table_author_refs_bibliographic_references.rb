class CreateJoinTableAuthorRefsBibliographicReferences < ActiveRecord::Migration[7.1]
  def change
    create_join_table :author_refs, :bibliographic_references do |t|
      t.index [:author_ref_id, :bibliographic_reference_id], name: 'idx_authref_bibref_authref_bibref'
      t.index [:bibliographic_reference_id, :author_ref_id], name: 'idx_bibref_authref_bibref_authref'
    end
  end
end
