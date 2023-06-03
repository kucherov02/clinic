ActiveAdmin.register Hospital do
  permit_params :name, :address, :creation_date, :facility_type, :city, :mortality

  index do
    selectable_column
    column :id
    column :name
    column :address
    column :creation_date
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :address
      row :creation_date
      row :facility_type
      row :city
      row :mortality
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :address
      f.input :creation_date
      f.input :facility_type
      f.input :city
      f.input :mortality
    end
    f.actions
  end
end
