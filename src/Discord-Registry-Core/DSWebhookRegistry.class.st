Class {
	#name : #DSWebhookRegistry,
	#superclass : #DSConnectionRegistry,
	#instVars : [
		'url',
		'name'
	],
	#category : 'Discord-Registry-Core'
}

{ #category : #examples }
DSWebhookRegistry class >> developmentChannel [
	<gtExample>
	<label: 'development channel'>
	^ self new
		url: 'https://discordapp.com/api/webhooks/WEBHOOK-ID/WEBHOOK-TOKEN';
		icon: (Smalltalk ui icons iconNamed: #pharo);
		name: 'development channel';
		yourself
		
]

{ #category : #examples }
DSWebhookRegistry class >> learningHelpChannel [
	<gtExample>
	<label: 'learning-help channel'>
	^ self new
		url: 'https://discordapp.com/api/webhooks/WEBHOOK-ID/WEBHOOK-TOKEN';
		icon: (Smalltalk ui icons iconNamed: #help);
		name: 'learning-help channel';
		yourself
		
]

{ #category : #visiting }
DSWebhookRegistry >> accept: aVisitor [
	^ aVisitor visitDSWebhookRegistry: self
]

{ #category : #accessing }
DSWebhookRegistry >> name [
	^ name
]

{ #category : #accessing }
DSWebhookRegistry >> name: anObject [
	name := anObject
]

{ #category : #accessing }
DSWebhookRegistry >> url [
	^ url
]

{ #category : #accessing }
DSWebhookRegistry >> url: anObject [
	url := anObject
]
