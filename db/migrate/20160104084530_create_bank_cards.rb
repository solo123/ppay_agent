class CreateBankCards < ActiveRecord::Migration
  def change
    create_table :bank_cards do |t|
      t.integer :bankcard_obj_id
      t.string :bankcard_obj_type

      t.string :bank_name
      t.string :bank_sub_branch
      t.string :account_name
      t.string :account_number
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
