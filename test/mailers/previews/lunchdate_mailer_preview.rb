# Preview all emails at http://localhost:3000/rails/mailers/lunchdate_mailer
class LunchdateMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/lunchdate_mailer/lunchdate_notification
  def lunchdate_notification
    LunchdateMailer.lunchdate_notification
  end

end
