class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :user
      t.string :title
      t.text :body
      t.references :course, index: true

      t.timestamps
    end
  end
end
