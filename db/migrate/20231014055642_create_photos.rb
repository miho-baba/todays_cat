class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.integer :customer_id
      t.string :cat_color
      t.text :photo_introduction
      t.string :title
      t.timestamps
    end
  end
end
