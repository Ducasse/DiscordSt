"
I represent Discord Embed Author object that can be send as JSON to a Discord  API.

See documentation at https://discordapp.com/developers/docs/resources/channel#embed-object-embed-author-structure

{{{
DSEmbedAuthor new 
	name: 'author name';
	url: 'http://example.com';
	iconUrl: http://example.com/icon.png';
	yourself
}}}

"
Class {
	#name : #DSEmbedAuthor,
	#superclass : #DSObject,
	#instVars : [
		'name',
		'url',
		'iconUrl',
		'proxyIconUrl'
	],
	#category : 'Discord-Core-Model'
}

{ #category : #accessing }
DSEmbedAuthor >> iconUrl [
	^ iconUrl
]

{ #category : #accessing }
DSEmbedAuthor >> iconUrl: anObject [
	iconUrl := anObject
]

{ #category : #accessing }
DSEmbedAuthor >> name [
	^ name
]

{ #category : #accessing }
DSEmbedAuthor >> name: anObject [
	name := anObject
]

{ #category : #accessing }
DSEmbedAuthor >> proxyIconUrl [
	^ proxyIconUrl
]

{ #category : #accessing }
DSEmbedAuthor >> proxyIconUrl: anObject [
	proxyIconUrl := anObject
]

{ #category : #accessing }
DSEmbedAuthor >> url [
	^ url
]

{ #category : #accessing }
DSEmbedAuthor >> url: anObject [
	url := anObject
]
