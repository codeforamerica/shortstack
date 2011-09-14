class CreateOrganizationSubdomains < ActiveRecord::Migration
  def self.up
    create_table :organization_subdomains do |t|
      t.integer :organization_id
      t.integer :subdomain_id

      t.timestamps
    end
    add_index :organization_subdomains, :organization_id
    add_index :organization_subdomains, :subdomain_id
  end

  def self.down
    remove_index :organization_subdomains, :subdomain_id
    remove_index :organization_subdomains, :organization_id
    drop_table :organization_subdomains
  end
end
