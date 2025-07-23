class AddCategoryToDoctors < ActiveRecord::Migration[7.2]
  def change
    add_reference :doctors, :category, null: false, foreign_key: true
  end
end
