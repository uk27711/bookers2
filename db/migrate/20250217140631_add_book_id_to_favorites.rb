class AddBookIdToFavorites < ActiveRecord::Migration[6.1]
  def change
    add_column :favorites, :book_id, :integer
    add_index :favorites, :book_id  # book_idにインデックスを追加
  end
end
