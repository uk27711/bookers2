class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.text :content
      belongs_to :user
      validates :content, presence: true

      t.timestamps
    end
  end
end
