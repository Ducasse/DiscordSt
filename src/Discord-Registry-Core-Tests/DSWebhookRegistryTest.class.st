"
A DSWebhookRegistryTest is a test class for testing the behavior of DSWebhookRegistry
"
Class {
	#name : #DSWebhookRegistryTest,
	#superclass : #DSConnectionRegistryTest,
	#category : 'Discord-Registry-Core-Tests'
}

{ #category : #running }
DSWebhookRegistryTest >> classToTest [
	^ DSWebhookRegistry
]

{ #category : #tests }
DSWebhookRegistryTest >> testUrl [
	| url |
	url := 'http://example.com'.
	registry := self classToTest new.
	registry url: url.
	self assert: registry url equals: url.
]
