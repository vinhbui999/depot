# frozen_string_literal: true

ActiveAdmin.register Product do
  config.filters = false
  permit_params :title, :price, :title, :image_url, :description

  index do
    selectable_column
    id_column
    column :title
    column :price
    actions
  end

  show do
    products = Product.find(params[:id])

    attributes_table_for products do
      row :image_url do |_im|
        image_tag url_for(products.image_url)
      end
      row :title
      row :price
      row :description
    end
  end

  form do |f|
    f.semantic_errors
    if f.object.new_record?
      f.inputs 'New Product' do
        f.input :title
        f.input :price
        f.input :description
        f.input :image_url, as: :hidden, input_html: { value: Product::DEFAULT_IMG }
      end

    else
      f.inputs 'Update Product' do
        f.input :title, require: true
        f.input :price, require: true
        f.input :description, require: true
      end
    end
    f.actions
  end
end
