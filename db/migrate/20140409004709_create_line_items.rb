class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :course_id
      t.integer :schedule_id

      t.timestamps
    end
  end
end
