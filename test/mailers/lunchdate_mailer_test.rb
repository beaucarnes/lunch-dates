require 'test_helper'

class LunchdateMailerTest < ActionMailer::TestCase
  test "lunchdate_notification" do
    mail = LunchdateMailer.lunchdate_notification
    assert_equal "Lunchdate notification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
