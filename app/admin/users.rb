ActiveAdmin.register User do
  config.filters = false
  permit_params :name, :password, :password_confirmation, :user, :orders
  index do
    selectable_column
    id_column
    column :name
    column :orders
    actions
  end

  show do
    user = User.find(params[:id])

    attributes_table_for user do
      row :id
      row :name
    end
  end

  form do |f|
    f.semantic_errors
    if f.object.new_record?
      f.inputs "New User" do
        f.semantic_errors *f.object.errors.keys
        f.inputs new_record: false do
          f.input :name
          f.input :password, as: :hidden, input_html: { value: User::DEFAULT_PASS }
          f.input :password_confirmation, as: :hidden, input_html: { value: User::DEFAULT_PASS }
        end
      end
    else
      f.inputs "Update User" do
        f.input :name, require: true
      end
    end
    f.actions
  end
end
