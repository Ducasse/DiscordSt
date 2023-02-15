"
I represent Discord Webhook object that can be send as JSON to a Discord Webhook API.

See documentation at https://discordapp.com/developers/docs/resources/webhook#jsonform-params.
"
Class {
	#name : #DSWebhookJsonPost,
	#superclass : #DSWebhookPost,
	#traits : 'TDSJsonPost',
	#classTraits : 'TDSJsonPost classTrait',
	#category : 'Discord-WebhookClient'
}

{ #category : #visiting }
DSWebhookJsonPost >> accept: aVisitor [ 
	^ aVisitor visitDSJSONWebhookPost: self
]

{ #category : #converting }
DSWebhookJsonPost >> asDataPost [
	"Convert JSON post to a data post."
	<return: #TDSDataPost>
	| data |
	data := DSWebhookDataPost new.
	data
		content: self content;
		username: self username;
		avatarUrl: self avatarUrl;
		isTextToSpeech: self isTextToSpeech;
		embeds: self embeds.
	^ data
]

{ #category : #testing }
DSWebhookJsonPost >> hasEmbeds [
	"Return true if a post includes embed objects"
	^ self embeds notEmpty
]
