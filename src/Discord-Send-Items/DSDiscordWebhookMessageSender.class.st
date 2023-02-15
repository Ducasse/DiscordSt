Class {
	#name : #DSDiscordWebhookMessageSender,
	#superclass : #DSDiscordMessageSender,
	#category : 'Discord-Send-Items'
}

{ #category : #'instance creation' }
DSDiscordWebhookMessageSender >> newDiscordSharedDataSender [
	^ DSDiscordWebhookSharedDataSender new
]

{ #category : #'instance creation' }
DSDiscordWebhookMessageSender >> newWebhookClient [
	^ DSWebhookClient new
]

{ #category : #private }
DSDiscordWebhookMessageSender >> sendMainMessage [
	messageBuilder := self newWebhookClient.
	messageBuilder url: self registry url.
	self items do: [ :eachItem | eachItem accept: self ].
	messageBuilder send.
]
