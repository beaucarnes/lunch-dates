class LunchdateMailer < ApplicationMailer

  def lunchdate_notification
    @lunchdate = LunchDate.find_by date: Date.today
    mail to: ENV['REMINDER_EMAIL_ADDRESS'] || "beaucarnes@gmail.com", subject: "Today's Lunch Date"
  end
  
end
