"
I represent Discord Embed Video object that can be send as JSON to a Discord  API.

See documentation at https://discordapp.com/developers/docs/resources/channel#embed-image-structure

{{{
DSEmbedVideo new 
	url: 'http://example.com/movie.avi';
	height: 600;
	width: 800;
	yourself
}}}

or as a part of DSEmbed object

{{{
DSEmbed new 
	videoUrl: 'http://example.com/movie.avi';
	videoHeight: 600;
	videoWidth: 800;
	yourself
}}}

"
Class {
	#name : 'DSEmbedVideo',
	#superclass : 'DSObject',
	#instVars : [
		'url',
		'height',
		'width'
	],
	#category : 'Discord-Core-Model',
	#package : 'Discord-Core',
	#tag : 'Model'
}

{ #category : 'accessing' }
DSEmbedVideo >> height [
	^ height
]

{ #category : 'accessing' }
DSEmbedVideo >> height: anObject [
	height := anObject
]

{ #category : 'accessing' }
DSEmbedVideo >> url [
	^ url
]

{ #category : 'accessing' }
DSEmbedVideo >> url: anObject [
	url := anObject
]

{ #category : 'accessing' }
DSEmbedVideo >> width [
	^ width
]

{ #category : 'accessing' }
DSEmbedVideo >> width: anObject [
	width := anObject
]
