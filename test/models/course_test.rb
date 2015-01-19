require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  fixtures :courses
  test "course attributes must not be empty" do
    course = Course.new
    assert course.invalid?
    assert course.errors[:title].any?
    assert course.errors[:professor].any?
    assert course.errors[:time].any?
    assert course.errors[:location].any?
  end

  test "Time ONE" do
  course = Course.new(:title => "CSE 3231: Software Requirements",
    :professor => "Bettina A. Bair",
    :time => "10:20 PM",
    :location => "Baker Systems 0180")
  assert course.valid?
  end

  test "Time TWO" do
  course = Course.new(:title => "CSE 3231: Software Requirements",
    :professor => "Bettina A. Bair",
    :time => "01:30 PM",
    :location => "Baker Systems 0180")
  assert course.valid?
  end

  test "Time THREE" do
  course = Course.new(:title => "CSE 3231: Software Requirements",
    :professor => "Bettina A. Bair",
    :time => "06:00 AM",
    :location => "Baker Systems 0180")
  assert course.valid?
  end

  test "Time FOUR" do
  course = Course.new(:title => "CSE 3231: Software Requirements",
    :professor => "Bettina A. Bair",
    :time => "12:25 PM",
    :location => "Baker Systems 0180")
  assert course.valid?
  end
  test "Time FIVE" do
  course = Course.new(:title => "CSE 3231: Software Requirements",
    :professor => "Bettina A. Bair",
    :time => "04:55 PM",
    :location => "Baker Systems 0180")
  assert course.valid?
  end

  test "Time SIX" do
  course = Course.new(:title => "CSE 3231: Software Requirements",
    :professor => "Bettina A. Bair",
    :time => "08:00 AM",
    :location => "Baker Systems 0180")
  assert course.valid?
  end
  test "Time SEVEN" do
  course = Course.new(:title => "CSE 3231: Software Requirements",
    :professor => "Bettina A. Bair",
    :time => "07:00 am",
    :location => "Baker Systems 0180")
  assert course.valid?
  end

  test "Time EIGHT" do
  course = Course.new(:title => "CSE 3231: Software Requirements",
    :professor => "Bettina A. Bair",
    :time => "15:00 PM",
    :location => "Baker Systems 0180")
  assert course.invalid?, "15:00 PM should be invalid"
  end
  test "Time NINE" do
  course = Course.new(:title => "CSE 3231: Software Requirements",
    :professor => "Bettina A. Bair",
    :time => "1:20 PM",
    :location => "Baker Systems 0180")
  assert course.valid?
  end

  test "Time TEN" do
  course = Course.new(:title => "CSE 3231: Software Requirements",
    :professor => "Bettina A. Bair",
    :time => "1",
    :location => "Baker Systems 0180")
  assert course.invalid?
  end

  test "Time ELEVEN" do
  course = Course.new(:title => "CSE 3231: Software Requirements",
    :professor => "Bettina A. Bair",
    :time => "1:00",
    :location => "Baker Systems 0180")
  assert course.invalid?
  end

  test "Time TWELVE" do
  course = Course.new(:title => "CSE 3231: Software Requirements",
    :professor => "Bettina A. Bair",
    :time => "12 PM",
    :location => "Baker Systems 0180")
  assert course.invalid?
  end
  test "Time THIRTEEN" do
  course = Course.new(:title => "CSE 3231: Software Requirements",
    :professor => "Bettina A. Bair",
    :time => "4:53 PM",
    :location => "Baker Systems 0180")
  assert course.invalid?
  end

  test "Time FOURTEEN" do
  course = Course.new(:title => "CSE 3231: Software Requirements",
    :professor => "Bettina A. Bair",
    :time => "51:00 AM",
    :location => "Baker Systems 0180")
  assert course.invalid?
  end
  test "Time FIFTEEN" do
  course = Course.new(:title => "CSE 3231: Software Requirements",
    :professor => "Bettina A. Bair",
    :time => "07:60 am",
    :location => "Baker Systems 0180")
  assert course.invalid?
  end

  test "Time SIXTEEN" do
  course = Course.new(:title => "CSE 3231: Software Requirements",
    :professor => "Bettina A. Bair",
    :time => "10:00PM",
    :location => "Baker Systems 0180")
  assert course.invalid?
  end

  test "Time SEVENTEEN" do
  course = Course.new(:title => "CSE 3231: Software Requirements",
    :professor => "Bettina A. Bair",
    :time => "10 PM",
    :location => "Baker Systems 0180")
  assert course.invalid?
  end

  test "course is not valid without a unique title" do
    course = Course.new(:title => courses(:webApps).title,
			:professor => "yyy",
			:time => "10:30 AM",
			:location => "xxx")
    assert !course.save
    assert_equal "has already been taken", course.errors[:title].join('; ')
  end

  



   
end
