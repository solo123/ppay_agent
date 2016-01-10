class CreateClearings < ActiveRecord::Migration
  def change
    create_table :clearings do |t|
      t.belongs_to :client
      t.string :trade_date
      t.integer :trade_count
      t.decimal :trade_amount, precision: 12, scale: 2
      t.decimal :trade_fee, precision: 12, scale: 2
      t.decimal :clearing_amount, precision: 12, scale: 2
      t.decimal :actual_amount, precision: 12, scale: 2
      t.belongs_to :clearing_status
      t.integer :status, default: 0
      
      t.timestamps
    end
  end
end
