"
I represent a Discord Overwrite Object.

See https://discordapp.com/developers/docs/resources/channel#overwrite-object

Field	Type	Description
id	snowflake	role or user id
type	string	either ""role"" or ""member""
allow	integer	permission bit set
deny	integer	permission bit set

"
Class {
	#name : 'DSOverwrite',
	#superclass : 'DSObject',
	#instVars : [
		'id',
		'type',
		'allow',
		'deny'
	],
	#category : 'Discord-Core-Model',
	#package : 'Discord-Core',
	#tag : 'Model'
}

{ #category : 'accessing' }
DSOverwrite >> allow [
	^ allow
]

{ #category : 'accessing' }
DSOverwrite >> allow: anObject [
	allow := anObject
]

{ #category : 'accessing' }
DSOverwrite >> deny [
	^ deny
]

{ #category : 'accessing' }
DSOverwrite >> deny: anObject [
	deny := anObject
]

{ #category : 'accessing' }
DSOverwrite >> id [
	^ id
]

{ #category : 'accessing' }
DSOverwrite >> id: anObject [
	id := anObject
]

{ #category : 'accessing' }
DSOverwrite >> type [
	^ type
]

{ #category : 'accessing' }
DSOverwrite >> type: anObject [
	type := anObject
]
