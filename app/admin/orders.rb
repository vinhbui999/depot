ActiveAdmin.register Order do
    config.filters = false
    config.clear_action_items!
    actions :all, except: %i[new edit]
    permit_params :name, :address, :email, :pay_type, :line_items, :user, :products, :cart_id

    index do
        selectable_column
        column :id
        column "Order Name", :name
        column :address
        column :email
        column :pay_type
        column :ship_date
        column :user
        actions
    end

    show do
        orders = Order.find(params[:id])

        attributes_table_for orders do
            row :name
            row :address
            row :email
            row :pay_type
            row :ship_date
            row :cart
            row :user
        end
    end
end