#Gère l'affichage (début de programme) et les saisies utilisateurs
require_relative 'lib/views/index.rb'

#Retourne les noms, départements et emails dans un hash ruby et copie dans db/emails.JSON
require_relative 'lib/app/townhalls_scrapper'
