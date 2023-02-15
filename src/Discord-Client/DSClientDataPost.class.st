"
I represent Discord Message post that can be send as multipart/form-data format to a Discord API. I am useful for sending files, images, byte arrays, etc.

See documentation at https://discordapp.com/developers/docs/resources/channel#create-message
"
Class {
	#name : #DSClientDataPost,
	#superclass : #DSClientPost,
	#traits : 'TDSDataPost',
	#classTraits : 'TDSDataPost classTrait',
	#instVars : [
		'mimeParts'
	],
	#category : 'Discord-Client'
}

{ #category : #visiting }
DSClientDataPost >> accept: aVisitor [ 
	^ aVisitor visitDSClientDataPost: self
]

{ #category : #testing }
DSClientDataPost >> hasEmbeds [
	"Return true if a post includes embed objects"
	^ self embed notNil
]

{ #category : #initialization }
DSClientDataPost >> initialize [
	super initialize.
	mimeParts := OrderedCollection new
]

{ #category : #adding }
DSClientDataPost >> mimeParts [
	"Return a collection of attachments (ZnMimePart objects)."
	<return: #OrderedCollection of: #ZnMimePart>
	^ mimeParts
]
