# frozen_string_literal: true

ActiveAdmin.register Cart do
  config.filters = false
  config.clear_action_items!
  actions :all, except: %i[new edit destroy]
  permit_params :id, :order_id, :line_items, :line_items_id

  index do
    selectable_column
    column :id
    column :order
    column :line_items
    actions
  end

  show do
    cart = Cart.find(params[:id])

    attributes_table_for cart do
      row :id
      row :order
      row :created_at
      row :updated_at
      row :line_items, &:line_items
    end
  end
end
