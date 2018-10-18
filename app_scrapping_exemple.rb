#!/usr/bin/ruby
require "json"
require "./lib/email_scrapper.rb"

zipcode = 972
city = "https://www.annuaire-des-mairies.com/martinique.html"
xpath = "/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]"

srappy_the_1337_scrapper = Scrapper.new(city, xpath, zipcode)

File.open("./db/emails.JSON","w") do |f|
	# There is nothing to say about that, i was tired...
	f.write(srappy_the_1337_scrapper.fetch_dem_in_di_ass.to_json)
end
