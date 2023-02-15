"
I represent Discord Message post that can be send as JSON or multipart/form-data format to a Discord API.

See documentation at https://discordapp.com/developers/docs/resources/channel#create-message
"
Class {
	#name : #DSClientJsonPost,
	#superclass : #DSClientPost,
	#traits : 'TDSJsonPost',
	#classTraits : 'TDSJsonPost classTrait',
	#category : 'Discord-Client'
}

{ #category : #visiting }
DSClientJsonPost >> accept: aVisitor [ 
	^ aVisitor visitDSClientJsonPost: self
]

{ #category : #visiting }
DSClientJsonPost >> asDataPost [
	"Convert a post into DSClientDataPost"
	| data |
	data := DSClientDataPost new.
	data
		content: self content;
		nonce: self nonce;
		isTextToSpeech: self isTextToSpeech;
		embed: self embed.
	^ data
]

{ #category : #testing }
DSClientJsonPost >> hasEmbeds [
	"Return true if a post includes embed objects"
	^ self embed notNil
]
