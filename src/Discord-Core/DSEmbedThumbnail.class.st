"
I represent Discord Embed Thumbnail object that can be send as JSON to a Discord  API.

See documentation at https://discordapp.com/developers/docs/resources/channel#embed-thumbnail-structure

{{{
DSEmbedThumbnail new 
	url: 'http://example.com/icon.png';
	height: 512;
	width: 512;
	yourself
}}}

or as a part of DSEmbed object

{{{
DSEmbed new 
	thumbnailUrl: 'http://example.com/icon.png';
	thumbnailHeight: 512;
	thumbnailWidth: 512;
	yourself
}}}

"
Class {
	#name : #DSEmbedThumbnail,
	#superclass : #DSObject,
	#instVars : [
		'url',
		'proxyUrl',
		'height',
		'width'
	],
	#category : 'Discord-Core-Model'
}

{ #category : #accessing }
DSEmbedThumbnail >> height [
	^ height
]

{ #category : #accessing }
DSEmbedThumbnail >> height: anObject [
	height := anObject
]

{ #category : #accessing }
DSEmbedThumbnail >> proxyUrl [
	^ proxyUrl
]

{ #category : #accessing }
DSEmbedThumbnail >> proxyUrl: anObject [
	proxyUrl := anObject
]

{ #category : #accessing }
DSEmbedThumbnail >> url [
	^ url
]

{ #category : #accessing }
DSEmbedThumbnail >> url: anObject [
	url := anObject
]

{ #category : #accessing }
DSEmbedThumbnail >> width [
	^ width
]

{ #category : #accessing }
DSEmbedThumbnail >> width: anObject [
	width := anObject
]
