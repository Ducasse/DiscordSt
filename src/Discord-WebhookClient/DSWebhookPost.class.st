"
I represent Discord Webhook object that can be send as JSON or multipart/form-data format to a Discord Webhook API.
I am an abstract class.

I am used by DSWebhookClient in order to construct a message to be send to a Discord Webhook.

See documentation at https://discordapp.com/developers/docs/resources/webhook#jsonform-params.

Field	Type	Description	Required
content	string	the message contents (up to 2000 characters)	one of content, file, embeds
username	string	override the default username of the webhook	false
avatar_url	string	override the default avatar of the webhook	false
tts	bool	true if this is a TTS message	false
file	file contents	the contents of the file being sent	one of content, file, embeds
embeds	array of embed objects	embedded rich content	one of content, file, embeds
			
For the webhook embed objects, you can set every field except type (it will be rich regardless of if you try to set it), provider, video, and any height, width, or proxy_url values for images.
"
Class {
	#name : #DSWebhookPost,
	#superclass : #DSObject,
	#instVars : [
		'content',
		'username',
		'avatarUrl',
		'isTextToSpeech',
		'embeds'
	],
	#category : 'Discord-WebhookClient'
}

{ #category : #adding }
DSWebhookPost >> addEmbed: aDSEmbed [ 
	^ self embeds addLast: aDSEmbed
]

{ #category : #accessing }
DSWebhookPost >> avatarUrl [
	^ avatarUrl
]

{ #category : #accessing }
DSWebhookPost >> avatarUrl: anObject [
	avatarUrl := anObject
]

{ #category : #accessing }
DSWebhookPost >> content [
	^ content
]

{ #category : #accessing }
DSWebhookPost >> content: anObject [
	"Set the message contents (up to 2000 characters)"
	| newValue |
	newValue := anObject ifNotNil: #asString.
	newValue ifNotNil: [ 
		newValue size > DSConstants maxMessageLenght 
			ifTrue: [ DSLongMessageError new
				content: newValue;
				signal: 'Content ', newValue size asString, 
					' long, max. is ', DSConstants maxMessageLenght asString ] ].
	content := newValue
]

{ #category : #accessing }
DSWebhookPost >> embeds [
	^ embeds
]

{ #category : #accessing }
DSWebhookPost >> embeds: anObject [
	embeds := anObject
]

{ #category : #'gt-inspector-extension' }
DSWebhookPost >> gtChildren [
	^ self embeds
]

{ #category : #initialization }
DSWebhookPost >> initialize [
	super initialize.
	embeds := OrderedCollection new.
]

{ #category : #accessing }
DSWebhookPost >> isTextToSpeech [
	^ isTextToSpeech
]

{ #category : #accessing }
DSWebhookPost >> isTextToSpeech: anObject [
	isTextToSpeech := anObject
]

{ #category : #accessing }
DSWebhookPost >> username [
	^ username
]

{ #category : #accessing }
DSWebhookPost >> username: anObject [
	username := anObject
]
