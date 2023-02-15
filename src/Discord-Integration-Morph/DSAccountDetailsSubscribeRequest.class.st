Class {
	#name : #DSAccountDetailsSubscribeRequest,
	#superclass : #DSAccountDetailsRequest,
	#category : 'Discord-Integration-Morph'
}

{ #category : #visiting }
DSAccountDetailsSubscribeRequest >> visitDSClientRegistry: aDSClientRegistry [
	aDSClientRegistry announcer
		when: DSAuthenticatedAnnouncement
		send: #handleUserAuthenticatedAnnouncement:
		to: self morph
]

{ #category : #visiting }
DSAccountDetailsSubscribeRequest >> visitDSWebhookRegistry: aDSWebhookRegistry [ 
	"nothing to do"
]

{ #category : #visiting }
DSAccountDetailsSubscribeRequest >> visitDSWebhookRegistryItemMorph: aDSWebhookRegistryItemMorph [ 
	"Nothing to do."
]
