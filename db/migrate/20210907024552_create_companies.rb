class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :email
      t.text :address
      t.string :phonenumber

      t.timestamps
    end
  end
end
