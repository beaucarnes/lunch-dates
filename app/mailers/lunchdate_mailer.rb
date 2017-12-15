class LunchdateMailer < ApplicationMailer

  def lunchdate_notification
    @lunchdate = LunchDate.find_by date: Date.today

    mail to: "beaucarnes@gmail.com", subject: "Today's Lunch Date"
  end
  
end
