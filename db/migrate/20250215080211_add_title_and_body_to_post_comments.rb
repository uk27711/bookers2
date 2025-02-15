class AddTitleAndBodyToPostComments < ActiveRecord::Migration[6.1]
  def change
    add_column :post_comments, :title, :string
    add_column :post_comments, :body, :text
  end
end
