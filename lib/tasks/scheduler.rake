namespace :scheduler do

    desc "This task is called by the Heroku scheduler add-on"
    task :create_lunch_dates => :environment do
      puts "Creating lunch dates..."
      LunchDate.create_lunch_dates
      puts "done."
    end
    
    task :send_reminder => :environment do
      LunchdateMailer.lunchdate_notification().deliver_now
    end

end