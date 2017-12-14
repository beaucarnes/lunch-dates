class LunchdatesController < ApplicationController

  def index
    @lunchdates = LunchDate.all
  end
  
  def create
    LunchDate.create_lunch_dates
    redirect_to lunchdates_url
  end
  
end