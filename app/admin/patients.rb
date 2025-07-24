ActiveAdmin.register Patient do
permit_params :first_name, :last_name, :phone, :email, :date_of_birth, :address, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :phone
    column :email
    column :date_of_birth
    actions
  end

  filter :first_name
  filter :last_name
  filter :phone
  filter :email
  filter :date_of_birth

  form do |f|
    f.inputs "Patient Info" do
      f.input :first_name
      f.input :last_name
      f.input :phone
      f.input :email
      f.input :date_of_birth, as: :datepicker
      f.input :address
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :first_name
      row :last_name
      row :phone
      row :email
      row :date_of_birth
      row :address
      row :created_at
      row :updated_at
    end
  end
end
