class CreateCodeTables < ActiveRecord::Migration
  def change
    create_table :code_tables do |t|
      t.string :name
      t.string :val
      t.integer :parent_id
      t.integer :status

      t.timestamps null: false
    end
  end
end
