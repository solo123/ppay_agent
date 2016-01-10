class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.belongs_to :client
      t.belongs_to :pos_machine
      t.string :sub_account, default: ''
      t.datetime :trade_date
      t.belongs_to :trade_type
      t.belongs_to :trade_result
      t.decimal :trade_amount, precision: 12, scale: 2
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
