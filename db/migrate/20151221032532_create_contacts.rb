class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name, index: true
      t.string :tel, index: true
      t.string :qq
      t.string :wechart
      t.string :cid
      t.datetime :cid_verified_date
      t.string :roles, default: ''
      t.integer :status, default: 0
      t.timestamps null: false
    end

    create_table :clients_contacts, id: false do |t|
      t.belongs_to :client, index: true
      t.belongs_to :contact, index: true
    end

    create_table :salesmen_contacts, id: false do |t|
      t.belongs_to :salesman, index: true
      t.belongs_to :contact, index: true
    end
  end
end
