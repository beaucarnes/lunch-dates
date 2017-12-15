namespace :scheduler do

    task :create_lunch_dates => :environment do
      puts "Creating lunch dates..."
      LunchDate.create_lunch_dates
      puts "done."
    end

    task :create_lunch_dates_if_first_of_month => :environment do
      today = Date.today
      first_of_month = Date.today.beginning_of_month
      if today == first_of_month
        puts "Creating lunch dates..."
        LunchDate.create_lunch_dates
        puts "done."
      else
        puts "No lunch dates created because it's not the first of the month."
      end
    end
    
    task :send_reminder => :environment do
      puts "Sending reminder of lunch date."
      LunchdateMailer.lunchdate_notification().deliver_now
    end

end