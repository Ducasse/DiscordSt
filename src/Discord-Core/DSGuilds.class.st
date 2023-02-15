"
I represent collection of DSUserGuilds
"
Class {
	#name : #DSGuilds,
	#superclass : #DSOrderedCollection,
	#category : 'Discord-Core-Collections'
}

{ #category : #examples }
DSGuilds class >> oneGuild [
	<gtExample>
	<label: 'One guild (server) with two channels'>
	^ self jsonMappingClass 
		read: #CollectionOfGuilds 
		withMapping: #collectionOfGuildsMappingFor:
		on: self jsonMappingClass jsonCollectionOfGuildsOne readStream
]

{ #category : #'gt-inspector-extension' }
DSGuilds >> gtInspectorMembers: composite [
	<gtInspectorPresentationOrder: -9>
	^ composite fastTree
		title: [ 'Members' translated ];
		display: [ self ];
		when: [ self notEmpty ];
		children: [ :item | item members ];
		expandedUntil: 0;
		yourself
]

{ #category : #'gt-inspector-extension' }
DSGuilds >> gtInspectorServers: composite [
	<gtInspectorPresentationOrder: -10>
	^ composite fastTree
		title: [ 'Servers' translated ];
		display: [ self ];
		when: [ self notEmpty ];
		children: [ :item | item children ];
		expandedUntil: 1;
		yourself
]

{ #category : #testing }
DSGuilds >> isAuthenticated [
	^ self notEmpty and: [ self anyOne isAuthenticated ]
]

{ #category : #enumerating }
DSGuilds >> named: guildName [ 
	"Return a DSGuildName object with the given name."
	^ self detect: [ :guild | guild name = guildName ]
]
