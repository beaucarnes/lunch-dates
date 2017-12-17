require 'test_helper'

class LunchdateMailerTest < ActionMailer::TestCase
  test "lunchdate_notification" do
    LunchDate.create_lunch_dates
    mail = LunchdateMailer.lunchdate_notification
    assert_equal "Today's Lunch Date", mail.subject
    assert_equal ["beaucarnes@gmail.com"], mail.from
  end

end
