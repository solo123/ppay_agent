class CreateSalesCommissions < ActiveRecord::Migration
  def change
    create_table :sales_commissions do |t|
      t.integer :sales_commission_obj_id
      t.string :sales_commission_obj_type

      t.string :sales_type
      t.integer :start_count, default: 0
      t.integer :end_count, default: 0
      t.decimal :percent, precision: 12, scale: 2, default: 0
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
