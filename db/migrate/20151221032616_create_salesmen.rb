class CreateSalesmen < ActiveRecord::Migration
  def change
    create_table :salesmen do |t|
      t.belongs_to :agent
      t.belongs_to :contact
      t.string :name
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
