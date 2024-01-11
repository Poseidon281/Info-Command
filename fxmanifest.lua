shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version 'cerulean'
game 'gta5'

name "BHL-Charinfo"
description "BHL-Charinfo is een krachtige FiveM resource die is ontworpen om de spelerservaring te verbeteren door gedetailleerde informatie weer te geven over het personage (character) waarmee een speler interacteert. Met deze resource kunnen spelers snel en gemakkelijk toegang krijgen tot belangrijke informatie over andere personages, zoals hun naam, groepslidmaatschap, financiële status, inventaris en meer."
author "Senna"
version "1.3.0"

shared_scripts {
	'shared/*.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/*.lua'
}
