require 'test_helper'

class LunchDateTest < ActiveSupport::TestCase
  test "LunchDates created correctly" do
    LunchDate.create_lunch_dates
    all_lunch_dates = LunchDate.all
    # Get array of workdays in current month
    work_days = []
    today = Date.today
    day = today.beginning_of_month
    month_end = today.end_of_month
    while day <= month_end
        if !day.saturday? && !day.sunday?
            work_days.push(day)
        end
        day = day + 1
    end
    assert all_lunch_dates.count == work_days.count, 'Wrong numer of lunch dates:' + all_lunch_dates.count.to_s + " " + work_days.count.to_s
    
    count = {}
    all_lunch_dates.each do |date|
      count[date.teammate_a.name] = count[date.teammate_a.name] ? count[date.teammate_a.name] + 1 : 1
    end
    assert count.values.max <= 3, 'User pays for more than three lunch dates.'
    
  end
end
