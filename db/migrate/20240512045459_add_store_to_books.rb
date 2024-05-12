class AddStoreToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :store, :string
  end
end
