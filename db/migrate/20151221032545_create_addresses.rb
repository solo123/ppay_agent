class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :addr_obj_id
      t.string :addr_obj_type

      t.integer :province_id
      t.integer :city_id
      t.string :street
      t.string :post_code
      t.integer :status, default: 1

      t.timestamps null: false
    end
  end
end
