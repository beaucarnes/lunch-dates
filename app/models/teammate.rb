class Teammate < ActiveRecord::Base
    has_many(:lunch_dates, :foreign_key => :teammate_a_id, :dependent => :destroy)
    has_many(:reverse_lunch_dates, :class_name => :LunchDate,
      :foreign_key => :teammate_b_id, :dependent => :destroy)
    
    attr_accessor :bio, :location, :pic_url
    
    def get_all_lunch_dates
      all_dates = []
      self.lunch_dates.each do |date|
        all_dates.push({teammate: date.teammate_b.name, date: date.date, pay: true})
      end
      self.reverse_lunch_dates.each do |date|
        all_dates.push({teammate: date.teammate_a.name, date: date.date, pay: false})
      end
      all_dates.sort_by!{|date| date[:date]}
      return all_dates
    end
    
    def load_twitter_data
      begin
        user_twitter = self[:twitter_username] ? $twitter.user(self[:twitter_username]) : nil
      rescue Exception
        puts 'Twitter user not found'
        user_twitter = nil
      end
      if user_twitter
        @bio = user_twitter.description
        @location = user_twitter.location
        @pic_url = user_twitter.profile_image_url
      end
    end
end
