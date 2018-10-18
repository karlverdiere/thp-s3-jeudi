require 'google_drive'
require 'dotenv'
require 'json'
require 'pry'

Dotenv.load

file = File.read('emails.json') # JSON version of the hash ville => email

data = JSON.parse(file) # Ruby version of the hash ville => email

session = GoogleDrive::Session.from_config("config.json") # Prompt credentials stored in config.json

  # Ce fichier a été fait depuis la DOC du repo suivant : https://github.com/gimite/google-drive-ruby#example-to-readwrite-spreadsheets

  # The below script will puts the title of files which already exist on Drive

  #session.files.each do |file|
  #  p file.key
  #end

  # The below script will download files which already exist on drive => Téléchargement ! (et non mise en ligne == upload)

  #file = session.file_by_title("hello.txt")
  #file.download_to_file(" emplacement où télécharger le fichier qui est sur Drive ")

# ------------ UPLOAD le fichier JSON

#session.upload_from_file("/Users/henri/Desktop/THP/S3/S3-J3-Scrap_JSON_CSV/lib/app/emails.json", "emails.json", convert: false)

my_ws = session.spreadsheet_by_key("1cNCGqThwb6uzo-SvAN51Pi2FnD3JiuIOmlbhVC4-JDI").worksheets[0]
#https://docs.google.com/spreadsheets/d/1cNCGqThwb6uzo-SvAN51Pi2FnD3JiuIOmlbhVC4-JDI/edit#gid=0 => clé trouvée via l'url lors du partage


my_ws[1, 1] = "VILLES"
my_ws[1, 2] = "ADRESSE MAILS"
my_ws.save


l_name = 2
C_name = 1

l_mail = 2
C_mail = 2

data.each do |key, value|
 my_ws[l_name, C_name] = key
 my_ws[l_mail, C_mail] = value
 l_name += 1
 l_mail +=1
end

my_ws.save
