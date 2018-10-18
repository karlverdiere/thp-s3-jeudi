#!/usr/bin/ruby
require "open-uri"
require "nokogiri"

class Scrapper
	public
	def initialize(html_page, path, zipcode)
		@email_list = Array.new
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
		page = Nokogiri::HTML(open(@html_page))
		puts(@html_page + "\nFetching emails...\n" + @html_page)
		page.xpath("//@href").grep(@zipcode).each do |link|
			link = link.to_s
			puts @email_list.push(get_email_webpage(link.gsub("./", "http://annuaire-des-mairies.com/")))
		end
		puts "...DONE !"
		return @email_list
	end

	# Recupere NOM/CODE POSTAL/EMAIL sur la page de la mairie
	def get_email_webpage(url)
		h = Hash.new
		page = Nokogiri::HTML(open(url))
		town_name = page.xpath("/html/body/div/main/section[1]/div/div/div/h1").text.split(" - ")
		email = page.xpath(@path).text
		return h = { [town_name] => email }
	end
end