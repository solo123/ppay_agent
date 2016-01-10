class AddContactToAgents < ActiveRecord::Migration
  def change
    create_table :agents_contacts, id: false do |t|
      t.belongs_to :agent, index: true
      t.belongs_to :contact, index: true
    end
  end
end
