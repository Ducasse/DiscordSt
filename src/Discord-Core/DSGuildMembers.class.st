"
I represent collection of DSGuildMember.
"
Class {
	#name : 'DSGuildMembers',
	#superclass : 'DSOrderedCollection',
	#category : 'Discord-Core-Collections',
	#package : 'Discord-Core',
	#tag : 'Collections'
}

{ #category : 'examples' }
DSGuildMembers class >> basic [

	^ self jsonMappingClass
		read: #CollectionOfGuildMembers
		withMapping: #collectionOfGuildMembersMappingFor:
		on: self jsonMappingClass jsonCollectionOfGuildMembersOne readStream
]
