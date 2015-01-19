class Course < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
  default_scope :order => 'title'
  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  
  #...
  private
    #ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end
  validates :title, :professor, :time, :location, :presence => true
  validates :title, :uniqueness => true
  validates :time, :format => {
    :multiline => true,
    :with	=> %r{^([0-1][0-2]|0[1-9]|[1-9]):[0-5][0,5] (AM|PM)$}i,
    :message => 'Must be of the format \'##:## AM\' or \'##:## PM\' where the first number can only be 0 or 1, the second number can be 0-9, the third number can be 0-5 and the fourth number can be 0 or 5'
  }
end
