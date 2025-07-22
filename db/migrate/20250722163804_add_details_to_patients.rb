class AddDetailsToPatients < ActiveRecord::Migration[7.2]
  def change
    add_column :patients, :first_name, :string
    add_column :patients, :last_name, :string
    add_column :patients, :date_of_birth, :date
    add_column :patients, :address, :string
    add_column :patients, :phone, :string
    add_index :patients, :phone, unique: true
  end
end
