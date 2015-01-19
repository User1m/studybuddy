class CombineItemsInSchedule < ActiveRecord::Migration
  def self.up
    #replace multiple items for a single course in a schedule with a single item
    Schedule.all.each do |schedule|
      #count the number of each course in the schedule, should be one
      sums = schedule.line_items.group(:course_id).sum(:quantity)

      sums.each do |course_id, quantity|
        if quantity > 1
          #remove individual items
          schedule.line_items.where(:course_id=>course_id).delete_all
          #replace with one item
          schedule.line_items.create(:course_id=>course_id, :quantity=>quantity)
        end
      end
    end
  end
  def self.down
    #split items with quantity > 1 into multiple ites
    LineItem.where("quantity>1").each do |line_item|
      #add individual items
      line_item.quantity.times do 
        LineItem.create :schedule_id=>line_item.schedule_id,
          :course_id=>line_item.course_id, :quantity=>1
      end
      #remove original item
      line_item.destroy
    end
  end
end
