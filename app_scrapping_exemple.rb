#!/usr/bin/ruby
require "json"
require "./lib/email_scrapper.rb"

xpath = "/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]"

exemple_zipcode = 972
exemple_region = "https://www.annuaire-des-mairies.com/martinique.html"

srappy_the_1337_scrapper = Scrapper.new(exemple_region, xpath, exemple_zipcode)
scrapper2 = Scrapper.new("http://www.annuaire-des-mairies.com/cotes-d-armor.html", xpath, 22)

File.open("./db/emails.JSON","w") do |f|
	f.write(srappy_the_1337_scrapper.start.to_json)
	f.write(scrapper2.start.to_json)
end