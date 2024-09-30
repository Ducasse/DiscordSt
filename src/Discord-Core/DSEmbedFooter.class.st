"
I represent Discord Footer Embed object that can be send as JSON to a Discord  API.

See documentation at https://discordapp.com/developers/docs/resources/channel#embed-footer-structure

{{{
DSEmbedFooter new 
	text: 'Example Company';
	iconUrl: 'http://example.com/icon.png';
}}}

or as a part of DSEmbed

{{{
DSEmbed new 
	footerText: 'Footer text';
	footerIconUrl: 'http://example.com/icon.png';
	yourself
}}}

"
Class {
	#name : 'DSEmbedFooter',
	#superclass : 'DSObject',
	#instVars : [
		'text',
		'iconUrl',
		'proxyIconUrl'
	],
	#category : 'Discord-Core-Model',
	#package : 'Discord-Core',
	#tag : 'Model'
}

{ #category : 'accessing' }
DSEmbedFooter >> iconUrl [
	^ iconUrl
]

{ #category : 'accessing' }
DSEmbedFooter >> iconUrl: anObject [
	iconUrl := anObject
]

{ #category : 'printing' }
DSEmbedFooter >> printFullMessageOn: aTextStream [ 
	aTextStream << self text 
]

{ #category : 'accessing' }
DSEmbedFooter >> proxyIconUrl [
	^ proxyIconUrl
]

{ #category : 'accessing' }
DSEmbedFooter >> proxyIconUrl: anObject [
	proxyIconUrl := anObject
]

{ #category : 'accessing' }
DSEmbedFooter >> text [
	^ text
]

{ #category : 'accessing' }
DSEmbedFooter >> text: anObject [
	text := anObject
]
