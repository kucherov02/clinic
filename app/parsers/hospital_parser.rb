require 'nokogiri'
require 'open-uri'
require 'faker'

class HospitalParser
  URL = 'https://www.hospitalsafetygrade.org/all-hospitals'.freeze

  def self.parse
    html = URI.open(URL)
    doc = Nokogiri::HTML(html)

    doc.css('li a').each do |link|
      name = link.text
      Hospital.create(
        name: name,
        address: Faker::Address.street_address,
        creation_date: Faker::Date.backward(days: 365)
      )
    end
  end
end
