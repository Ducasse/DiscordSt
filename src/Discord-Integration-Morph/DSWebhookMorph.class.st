Class {
	#name : #DSWebhookMorph,
	#superclass : #DSPanelMorph,
	#category : 'Discord-Integration-Morph'
}

{ #category : #initialization }
DSWebhookMorph >> initialize [
	super initialize.
	self height: 1.
]

{ #category : #testing }
DSWebhookMorph >> isWebhookMorph [
	^ true
]
