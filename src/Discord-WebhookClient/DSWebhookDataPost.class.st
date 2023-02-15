"
I represent Discord Webhook object that can be send as multipart/form-data to a Discord Webhook API. I am useful for sending files, images, byte arrays, etc.

See documentation at https://discordapp.com/developers/docs/resources/webhook#jsonform-params.

"
Class {
	#name : #DSWebhookDataPost,
	#superclass : #DSWebhookPost,
	#traits : 'TDSDataPost',
	#classTraits : 'TDSDataPost classTrait',
	#instVars : [
		'mimeParts'
	],
	#category : 'Discord-WebhookClient'
}

{ #category : #visiting }
DSWebhookDataPost >> accept: aVisitor [ 
	^ aVisitor visitDSDataWebhookPost: self
]

{ #category : #testing }
DSWebhookDataPost >> hasEmbeds [
	"Return true if a post includes embed objects"
	^ self embeds notEmpty
]

{ #category : #initialization }
DSWebhookDataPost >> initialize [
	super initialize.
	mimeParts := OrderedCollection new.
]

{ #category : #adding }
DSWebhookDataPost >> mimeParts [
	"Return a collection of attachments (ZnMimePart objects)."
	<return: #OrderedCollection of: #ZnMimePart>
	^ mimeParts
]
