class Schedule < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy
  def add_course(course_id)
    current_item = line_items.find_by_course_id(course_id)
    if current_item
      current_item.quantity = 1
      #want a message that says class is already in your cart here
    else
      current_item = line_items.build(:course_id => course_id)
    end
    current_item
  end
end
