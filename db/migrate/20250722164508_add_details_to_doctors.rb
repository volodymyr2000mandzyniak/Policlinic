class AddDetailsToDoctors < ActiveRecord::Migration[7.2]
  def change
    add_column :doctors, :first_name, :string
    add_column :doctors, :last_name, :string
    add_column :doctors, :date_of_birth, :date
    add_column :doctors, :address, :string
    add_column :doctors, :phone, :string

    add_index :doctors, :phone, unique: true

  end
end
