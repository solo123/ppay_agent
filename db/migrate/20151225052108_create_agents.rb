class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.belongs_to :user
      t.belongs_to :company
      t.belongs_to :cooperation_type
      
      t.datetime :cooperation_date
      t.integer :t0_enabled
      t.string :bank_biz_types
      t.text :cooperation_location
      t.decimal :deposit, precision: 12, scale: 2
      t.decimal :amounts_payable, precision: 12, scale: 2
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
