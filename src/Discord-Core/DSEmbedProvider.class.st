"
I represent Discord Embed Provider object that can be send as JSON to a Discord  API.

See documentation at https://discordapp.com/developers/docs/resources/channel#embed-provider-structure

{{{
DSEmbedProvider new 
	name: 'Pharo';
	url: 'http://example.com/icon.png';
	yourself
}}}

or as a part of DSEmbed object

{{{
DSEmbed new 
	providerName: 'Pharo';
	providerUrl: 'http://example.com/icon.png';
	yourself
}}}

"
Class {
	#name : #DSEmbedProvider,
	#superclass : #DSObject,
	#instVars : [
		'name',
		'url'
	],
	#category : 'Discord-Core-Model'
}

{ #category : #accessing }
DSEmbedProvider >> name [
	^ name
]

{ #category : #accessing }
DSEmbedProvider >> name: anObject [
	name := anObject
]

{ #category : #accessing }
DSEmbedProvider >> url [
	^ url
]

{ #category : #accessing }
DSEmbedProvider >> url: anObject [
	url := anObject
]
