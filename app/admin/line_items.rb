# frozen_string_literal: true

ActiveAdmin.register LineItem do
  config.filters = false
  config.clear_action_items!
  actions :all, except: %i[new edit destroy]
  permit_params :cart, :quantity, :product_price, :product

  index do
    selectable_column
    column 'Line Item Id', :id
    column :product
    column :cart
    column :order
    column :quantity
    column :product_price
    column :total_price
    actions
  end

  show do
    line_item = LineItem.find(params[:id])
    attributes_table_for line_item do
      row :order
      row :cart
      row :product
      row :quantity
      row :product_price
    end
  end
end
