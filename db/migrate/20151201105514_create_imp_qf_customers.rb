class CreateImpQfCustomers < ActiveRecord::Migration
  def change
    create_table :imp_qf_customers do |t|
      t.string :shid
      t.string :hylx
      t.string :dm
      t.string :lxr
      t.string :sj
      t.date :rwsj
      t.string :sf
      t.string :cs
      t.text :dz
      t.string :ywy
      t.string :fl
      t.string :zdcm
      t.decimal :jjkdbxe, precision: 12, scale: 2
      t.decimal :jjkdyxe, precision: 12, scale: 2
      t.decimal :xykdbxe, precision: 12, scale: 2
      t.decimal :xykdyxe, precision: 12, scale: 2
      t.integer :imp_log_id
      t.integer :zt, default: 0

      t.timestamps null: false

    end
  end
end
