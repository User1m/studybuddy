class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title
      t.string :professor
      t.string :time
      t.string :location

      t.timestamps
    end
  end
end
