class CreatePosMachines < ActiveRecord::Migration
  def change
    create_table :pos_machines do |t|
      t.string :serial_number
      t.belongs_to :client
      t.string :brand
      t.string :model
      t.string :info
      t.integer :status, default: 0


      t.timestamps null: false
    end
  end
end
