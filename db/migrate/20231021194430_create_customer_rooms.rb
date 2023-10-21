class CreateCustomerRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :customer_rooms do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
