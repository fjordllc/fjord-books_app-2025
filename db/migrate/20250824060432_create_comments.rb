class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :commentable, polymorphic: true, null: false
      t.text :content, null: false

      t.timestamps
    end
  end
end
