ActiveAdmin.register Doctor do
  permit_params :first_name, :last_name, :phone, :email, :date_of_birth,
                :address, :category_id, :approved, :password, :password_confirmation

  menu parent: "Doctors", label: "Усі лікарі"

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :phone
    column :email
    column :category
    column("Статус") do |doctor|
      status_tag (doctor.approved? ? "Підтверджено" : "На розгляді"), class: doctor.approved? ? "status-ok" : "status-warning"
    end
    actions
  end

  filter :first_name
  filter :approved

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :phone
      f.input :email
      f.input :date_of_birth, as: :datepicker
      f.input :address
      f.input :category
      f.input :approved
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end


  # Кастомний маршрут
  member_action :approve, method: :put do
    resource.update(approved: true)
    redirect_to admin_new_doctors_path, notice: "Лікаря підтверджено"
  end

  member_action :reject, method: :delete do
    resource.destroy
    redirect_to admin_new_doctors_path, alert: "Лікаря відхилено і видалено"
  end
end
