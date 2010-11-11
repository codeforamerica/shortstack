class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :address
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :country
      t.string :lat
      t.string :long
      t.string :addressable_type
      t.integer :addressable_id
      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
