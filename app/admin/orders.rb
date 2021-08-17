ActiveAdmin.register Order do
    config.filters = false
    config.clear_action_items!
    actions :all, except: %i[new edit]
    permit_params :name, :address, :email, :pay_type, :line_items, :user, :products, :cart_id

    controller do
        def new
          @order = Order.new()
        end
      end

    index do
        selectable_column
        column :name
        column :address
        column :email
        column :pay_type
        column :ship_date
        column :cart_id
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
        end
    end

    form do |f|
        f.semantic_errors
        f.inputs do
            f.input :user, require: true
            f.input :name
            f.input :address, input_html: {rows: 1, cols: 40}
            f.input :email
            f.input :pay_type
            f.input :ship_date
            f.input :line_item
        end
        f.actions
    end
end