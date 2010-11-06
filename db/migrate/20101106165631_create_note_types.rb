class CreateNoteTypes < ActiveRecord::Migration
  def self.up
    create_table :note_types do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :note_types
  end
end
