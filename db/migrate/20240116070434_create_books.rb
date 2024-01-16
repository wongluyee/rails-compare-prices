class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :link
      t.string :image
      t.string :price

      t.timestamps
    end
  end
end
