# frozen_string_literal: true

ActiveAdmin.register Company do
  config.filters = false
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :address
    column :phonenumber
    actions
  end
end
