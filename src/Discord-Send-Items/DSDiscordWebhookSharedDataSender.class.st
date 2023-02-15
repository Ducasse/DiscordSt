Class {
	#name : #DSDiscordWebhookSharedDataSender,
	#superclass : #DSDiscordSharedDataSender,
	#category : 'Discord-Send-Items'
}

{ #category : #initialize }
DSDiscordWebhookSharedDataSender >> initializeMessageBuilder [
	messageBuilder := self newWebhookClient.
	messageBuilder setWaitForResponse.
	messageBuilder url: self registry url.

]

{ #category : #'instance creation' }
DSDiscordWebhookSharedDataSender >> newWebhookClient [
	^ DSWebhookClient new
]
