class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :phone
      t.string :email
      t.string :twitter
      t.string :facebook
      t.string :linkedin
      t.string :github      
      t.integer :contactable_id
      t.string :contactable_type

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
