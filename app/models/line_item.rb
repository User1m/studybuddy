class LineItem < ActiveRecord::Base
  belongs_to :course
  belongs_to :schedule
end
