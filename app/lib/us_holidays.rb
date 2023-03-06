require 'httparty'
require 'pry'
require './app/lib/holiday_search'

holidays = HolidaySearch.new.holiday_information

holidays[0..2].each do |holiday|
  holiday.name
  holiday.date
end