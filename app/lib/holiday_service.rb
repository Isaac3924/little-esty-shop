require 'httparty'

class HolidayService
  def holidays
     get_url("https://date.nager.at/api/v3/NextPublicHolidays/US")
  end

  def get_url(url) #Make a GET request
    # Talking to the API
    response = HTTParty.get(url) # GET
    parsed_holidays = JSON.parse(response.body, symbolize_names: true) #JSON -> Ruby
  end
end