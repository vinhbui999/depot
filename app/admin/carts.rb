ActiveAdmin.register Cart do
  config.filters = false
  config.clear_action_items!
  actions :all, except: %i[new edit]
  permit_params :id, :order_id

  index do
    selectable_column
    column :id
    column :order_id
    actions
  end

  show do
    cart = Cart.find(params[:id])

    attributes_table_for cart do
      row :order_id
      row :id
      row :created_at
      row :updated_at
    end
  end
end
