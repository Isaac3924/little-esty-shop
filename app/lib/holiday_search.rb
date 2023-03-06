require './app/lib/holiday_service'
require './app/lib/holiday'

class HolidaySearch
  def service
    HolidayService.new
  end

  def holiday_information
    service.holidays.map do |data|
      Holiday.new(data)
    end
  end
end