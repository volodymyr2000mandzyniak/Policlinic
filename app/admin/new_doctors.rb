# app/admin/new_doctors.rb
ActiveAdmin.register_page "new_doctors" do
  menu label: "Нові лікарі", priority: 2, parent: "Doctors"

  content title: "Лікарі на розгляді" do
    doctors = Doctor.where(approved: [false, nil]).order(created_at: :desc)

    if doctors.any?
      table_for doctors do
        column :id
        column :first_name
        column :last_name
        column :email
        column :phone
        column :category
        column :created_at
        column("Дія") do |doctor|
          span do
            link_to "✅ Підтвердити", approve_admin_doctor_path(doctor), method: :put, class: "btn btn-sm btn-success me-2"
          end
          span do
            link_to "🗑️ Відхилити", reject_admin_doctor_path(doctor), method: :delete, data: { confirm: "Ви впевнені?" }, class: "btn btn-sm btn-danger"
          end
        end
      end
    else
      para "Немає лікарів на розгляді ✅", class: "text-muted"
    end
  end
end
