#!/usr/bin/ruby
require "open-uri"
require "nokogiri"
require "json"
require "csv"

class Scrapper
	public
	def initialize(html_page, path, zipcode)
		@html_page = html_page
		@path = path
		@zipcode = zip_to_regex(String(zipcode)) # Transforme le code en string dans tous les cas
	end

	# Launcher
	def start
		get_townhalls_url
	end

	private
	# Transcrit un code postal (string ou int) vers une regex
	def zip_to_regex(zipcode)
		return @zipcode = Regexp.new(zipcode)
	end

	# Recupere les URL de chaque mairie et appelle get_email_webpage pour chacune d'entre elle
	def get_townhalls_url
		@email_list = Array.new
		page = Nokogiri::HTML(open(@html_page))
		puts(@html_page + "\nFetching emails...\n" + @html_page)
		page.xpath("//@href").grep(@zipcode).each do |link|
			link = link.to_s
			@email_list.push(get_email_webpage(link.gsub("./", "http://annuaire-des-mairies.com/")).to_s)
		end
		puts "...DONE !"
		return @email_list
	end

	# Recupere NOM/CODE POSTAL/EMAIL sur la page de la mairie
	def get_email_webpage(url)
		h = Hash.new
		page = Nokogiri::HTML(open(url))
		email = page.xpath(@path).text
		town_name = page.xpath("/html/body/div/main/section[1]/div/div/div/h1").text.split(" - ")
		return h = { [town_name[0].to_sym, town_name[1].to_sym] => email }
	end
end

def scrapping
	xpath = "/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]"
	scrapper = Scrapper.new("http://www.annuaire-des-mairies.com/martinique.html", xpath, 972)

	File.open("../../db/emails.JSON","w") do |f|
		f.write(scrapper.start)
	end
end

scrapping