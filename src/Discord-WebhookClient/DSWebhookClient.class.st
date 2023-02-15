"
I execute Discord webhook using
POST/webhooks/{webhook.id}/{webhook.token}.

See documentation at https://discordapp.com/developers/docs/resources/webhook#execute-webhook

Basic usage is the following:

{{{
DSWebhookClient new 
	url: 'https://discordapp.com/api/webhooks/webhook-id/webhook-token';
	message: 'Hello! I am a Bot executed from Pharo';
	send
}}}

You can obtain the URL link from Discord application.
"
Class {
	#name : #DSWebhookClient,
	#superclass : #Object,
	#traits : 'TDSWebhookPostBuilder + TDSUnifiedPublishInterface',
	#classTraits : 'TDSWebhookPostBuilder classTrait + TDSUnifiedPublishInterface classTrait',
	#instVars : [
		'url',
		'post',
		'waitForResponse',
		'ifFailBlock'
	],
	#category : 'Discord-WebhookClient'
}

{ #category : #examples }
DSWebhookClient class >> handleNetworkError [
	<gtExample>
	<label: 'Handle any network error'>

	^ DSWebhookClient new 
		url: 'https://discordapp.com/api/webhooks/WEBHOOK-ID/WEBHOOK-TOKEN';
		message: 'Hello! I am a Bot executed from Pharo';
		ifFail: [ :exception | Transcript show: exception ];
		yourself ";
		send"
]

{ #category : #examples }
DSWebhookClient class >> ignoreAnyNetworkError [
	<gtExample>
	<label: 'Ignore any network error'>

	^ DSWebhookClient new 
		url: 'https://discordapp.com/api/webhooks/WEBHOOK-ID/WEBHOOK-TOKEN';
		message: 'Hello! I am a Bot executed from Pharo';
		supressNetworkErrors;
		yourself ";
		send"
]

{ #category : #examples }
DSWebhookClient class >> postEmbedRichObject [
	<gtExample>
	<label: 'Post embed rich object with username and avatar icon'>

	^ DSWebhookClient new 
		url: 'https://discordapp.com/api/webhooks/WEBHOOK-ID/WEBHOOK-TOKEN';
		embedTitle: 'Discord Bot Announcement';
		embedDescription: 'Hello! I am a Bot executed from [Pharo](http://pharo.org)';
		embedUrl: 'https://github.com/JurajKubelka/DiscordSt';
		embedColor: Color green;
		embedFooterText: 'Discord API in Pharo';
		embedFooterIconUrl: 'https://discordapp.com/assets/2c21aeda16de354ba5334551a883b481.png';
		yourself ";
		send"
]

{ #category : #examples }
DSWebhookClient class >> postFormAsScreenshot [
	<gtExample>
	<label: 'Post a Form object as an attached screenshot'>

	^ DSWebhookClient new 
		url: 'https://discordapp.com/api/webhooks/WEBHOOK-ID/WEBHOOK-TOKEN';
		message: 'This is a help icon used in the Pharo image';
		fileName: 'help-icon.png' form: #help asIcon;
		yourself ";
		send"
]

{ #category : #examples }
DSWebhookClient class >> postImage [
	<gtExample>
	<label: 'Post an image or any other file'>

	^ DSWebhookClient new
		url: 'https://discordapp.com/api/webhooks/WEBHOOK-ID/WEBHOOK-TOKEN';
		message: 'This message includes an image';
		fileName: 'pharo-logo.png' 
		bytes: (ZnEasy 
			get: 'http://files.pharo.org/media/logo/icon-opaque-512x512.png') contents;
		yourself ";
		send"
]

{ #category : #examples }
DSWebhookClient class >> postMorphAsScreenshot [
	<gtExample>
	<label: 'Post a Morph object as an attached screenshot'>

	^ DSWebhookClient new 
		url: 'https://discordapp.com/api/webhooks/WEBHOOK-ID/WEBHOOK-TOKEN';
		username: 'Pharo Screenshot';
		avatarUrl: 'http://files.pharo.org/media/logo/icon-opaque-512x512.png';
		fileName: 'screen.png' morph: World;
		yourself ";
		send"
]

{ #category : #examples }
DSWebhookClient class >> postSimpleMessage [
	<gtExample>
	<label: 'Post simple message'>

	^ DSWebhookClient new 
		url: 'https://discordapp.com/api/webhooks/WEBHOOK-ID/WEBHOOK-TOKEN';
		message: 'Hello! I am a Bot executed from [Pharo](http://pharo.org). You can use Markdown.';
		yourself ";
		send"
]

{ #category : #examples }
DSWebhookClient class >> postSimpleMessageWithUsernameAndAvatar [
	<gtExample>
	<label: 'Post simple message with username and avatar icon'>

	^ DSWebhookClient new 
		url: 'https://discordapp.com/api/webhooks/WEBHOOK-ID/WEBHOOK-TOKEN';
		message: 'Hello! I am a Bot executed from [Pharo](http://pharo.org). You can use Markdown.';
		username: 'Pharo Welcome';
		avatarUrl: 'http://files.pharo.org/media/logo/icon-opaque-512x512.png';
		yourself ";
		send"
]

{ #category : #'protocol - embed' }
DSWebhookClient >> embeds [
	"Return a collection of embed objects"
	<return: #Array of: #DSEmbed>
	^ self post embeds
]

{ #category : #configuration }
DSWebhookClient >> ifFail: anObject [
	self ifFailBlock: anObject
]

{ #category : #accessing }
DSWebhookClient >> ifFailBlock [
	^ ifFailBlock
]

{ #category : #accessing }
DSWebhookClient >> ifFailBlock: anObject [
	ifFailBlock := anObject
]

{ #category : #initialization }
DSWebhookClient >> initialize [
	super initialize.
	post := self newJSONPost.
	waitForResponse := false.
	ifFailBlock := [ :exception | exception pass ].
]

{ #category : #'instance creation' }
DSWebhookClient >> newJSONPost [
	^ DSWebhookJsonPost new
]

{ #category : #parsing }
DSWebhookClient >> parseMessage: aZnStringEntity [ 
	| message |
	message := DSModelJsonMapping
		read: DSMessage
		withMapping: #messageMappingFor:
		on: aZnStringEntity contents readStream.
	^ message
]

{ #category : #private }
DSWebhookClient >> post [
	"Return a post object."
	^ post
]

{ #category : #private }
DSWebhookClient >> post: aPost [
	"Set a post object."
	post := aPost
]

{ #category : #'protocol - sending' }
DSWebhookClient >> send [
	"Send a message to a particular target.
	In case of Webhooks it is a Webhook URL.
	In case of Bots and User Clients it is a Channel object."
	<return: #DSMessage or: nil>
	| entity response |
	entity := DSPostToEntityCommand new
		post: self post;
		execute;
		entity.
	response := ZnClient new
		url: self url;
		entity: entity;
		ifFail: self ifFailBlock;
		post;
		response.
	response ifNil: [ ^ nil ].
	^ response isSuccess 
		ifTrue: [ 
			response isNoContent
				ifTrue: [ DSMessage new ]
				ifFalse: [ self parseMessage: response contents ] ]
		ifFalse: [ [ DSResponseError new
			response: response;
			signal: response contents ] 
				on: Error
				do: self ifFailBlock ]
]

{ #category : #configuration }
DSWebhookClient >> setWaitForResponse [
	waitForResponse := true
]

{ #category : #configuration }
DSWebhookClient >> supressNetworkErrors [
	"Ignore network errors during the requests."
	self ifFail: [ :exception | exception ]
]

{ #category : #'protocol - sending' }
DSWebhookClient >> target: aZnUrl [
	"Set a target where a particular message should be sent.
	In case of Webhooks it is a Webhook URL."
	self url: aZnUrl
]

{ #category : #configuration }
DSWebhookClient >> unsetWaitForResponse [
	waitForResponse := false
]

{ #category : #accessing }
DSWebhookClient >> url [
	^ url ifNotNil: [ :anUrl |
		anUrl queryAt: #wait put: self waitForResponse ]
]

{ #category : #accessing }
DSWebhookClient >> url: anObject [
	url := anObject asZnUrl
]

{ #category : #accessing }
DSWebhookClient >> waitForResponse [
	^ waitForResponse
]

{ #category : #accessing }
DSWebhookClient >> waitForResponse: anObject [
	waitForResponse := anObject
]
