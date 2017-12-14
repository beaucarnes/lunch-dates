class LunchDate < ActiveRecord::Base
    belongs_to :teammate_a, :class_name => :Teammate
    belongs_to :teammate_b, :class_name => :Teammate
    
    def LunchDate.create_lunch_dates
        LunchDate.destroy_all
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
        
        # Create random list of teammates
        shuffled_teammates = []
        loop do
            shuffled_teammates = shuffled_teammates.concat(Teammate.all.shuffle)
            break if shuffled_teammates.length >= work_days.length * 2
        end
        
        # Create lunch dates, making sure people don't pay more than three times (first teammate pays)
        count = {}
        work_days.each_with_index do |work_day, i|
            i1 = i*2 # index of first teammate
            i2 = i1 + 1 # index of second teammate
            
            first_teammate_buy_count = count[shuffled_teammates[i1][:name]]
            second_teammate_buy_count = count[shuffled_teammates[i2][:name]]
            puts "BEFORE"

            puts shuffled_teammates[i1][:name], count[shuffled_teammates[i1][:name]], shuffled_teammates[i2][:name], count[shuffled_teammates[i2][:name]]
            # If first teammate has paid for lunch at least two more times than second teammate, swap places.
            if first_teammate_buy_count && 
                (first_teammate_buy_count - (second_teammate_buy_count ? second_teammate_buy_count : 0)) >= 2
                puts "MORE SWAP"
                puts shuffled_teammates[i1][:name]
                shuffled_teammates[i1], shuffled_teammates[i2] = shuffled_teammates[i2], shuffled_teammates[i1]
                puts shuffled_teammates[i1][:name]
            # Check if first teammate has paid for three lunches or more
            elsif first_teammate_buy_count && first_teammate_buy_count >= 3
                # If so, check if second teammate has paid for less than three lunches
                if !second_teammate_buy_count || second_teammate_buy_count < 3
                    # If so, swap with first teammate
                    puts "THREE SWAP"
                    shuffled_teammates[i1].name
                    shuffled_teammates[i1], shuffled_teammates[i2] = shuffled_teammates[i2], shuffled_teammates[i1]
                    shuffled_teammates[i1].name
                else # Find next person in shuffled list who has payed for less than three lunches
                    ((i2 + 1)..shuffled_teammates.length).each do |n|
                        if count.key?(shuffled_teammates[n][:name])  && count[shuffled_teammates[n][:name]] < 3
                            # Swap
                            shuffled_teammates[i1], shuffled_teammates[n] = shuffled_teammates[n], shuffled_teammates[i1]
                            break
                        end
                    end
                end
            end
            
            count[shuffled_teammates[i1][:name]] = count[shuffled_teammates[i1][:name]] ? count[shuffled_teammates[i1][:name]] + 1 : 1
            LunchDate.create(teammate_a: shuffled_teammates[i1], teammate_b: shuffled_teammates[i2], date: work_day)
            puts "AFTER"
            puts shuffled_teammates[i1][:name], count[shuffled_teammates[i1][:name]], shuffled_teammates[i2][:name], count[shuffled_teammates[i2][:name]]
        end        
        puts count
        puts "!!!!!!!" if count.has_value?(4)
    end
    
end
