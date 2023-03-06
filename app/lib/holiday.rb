class Holiday
  attr_reader :date,
              :localName,
              :name,
              :countryCode,
              :fixed,
              :global,
              :countries,
              :launchYear,
              :types
  def initialize(data)
    @date = data[:date]
    @localName = data[:localName]
    @name = data[:name]
    @countryCode = data[:countryCode]
    @fixed = data[:fixed]
    @global = data[:global]
    @countries = data[:countries]
    @launchYear = data[:launchYear]
    @types = data[:types]
  end
end