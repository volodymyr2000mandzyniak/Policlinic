ActiveAdmin.register Category do
  permit_params :title

  index do
    selectable_column
    id_column
    column :title
    column "Doctors Count" do |category|
      category.doctors.count
    end
    actions
  end

  filter :title

  form do |f|
    f.inputs "Category Info" do
      f.input :title
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :title
      row :created_at
      row :updated_at
      row "Doctors Count" do |category|
        category.doctors.count
      end
    end
  end
end
