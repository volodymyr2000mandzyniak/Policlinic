ActiveAdmin.register Doctor do
  permit_params :first_name, :last_name, :phone, :email, :date_of_birth, :address, :category_id, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :phone
    column :email
    column :category
    actions
  end

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :phone
      f.input :email
      f.input :date_of_birth, as: :datepicker
      f.input :address
      f.input :category
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
