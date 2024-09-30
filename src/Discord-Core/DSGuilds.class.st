"
I represent collection of DSUserGuilds
"
Class {
	#name : 'DSGuilds',
	#superclass : 'DSOrderedCollection',
	#category : 'Discord-Core-Collections',
	#package : 'Discord-Core',
	#tag : 'Collections'
}

{ #category : 'examples' }
DSGuilds class >> oneGuild [
	"One guild (server) with two channels"
	
	^ self jsonMappingClass 
		read: #CollectionOfGuilds 
		withMapping: #collectionOfGuildsMappingFor:
		on: self jsonMappingClass jsonCollectionOfGuildsOne readStream
]

{ #category : 'testing' }
DSGuilds >> isAuthenticated [
	^ self notEmpty and: [ self anyOne isAuthenticated ]
]

{ #category : 'enumerating' }
DSGuilds >> named: guildName [ 
	"Return a DSGuildName object with the given name."
	^ self detect: [ :guild | guild name = guildName ]
]
