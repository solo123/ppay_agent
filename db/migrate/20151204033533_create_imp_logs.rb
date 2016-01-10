class CreateImpLogs < ActiveRecord::Migration
  def change
    create_table :imp_logs do |t|
      t.integer :uid
      t.string :title
      t.string :received_at
      t.string :mail_from
      t.string :detail, default: ''
      t.integer :status, default: 0

      t.timestamps null: false
    end

  end
end
