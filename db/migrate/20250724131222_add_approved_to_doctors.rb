class AddApprovedToDoctors < ActiveRecord::Migration[7.2]
  def change
    add_column :doctors, :approved, :boolean
  end
end
