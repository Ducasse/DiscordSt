"
A DSSendRegistriesItemTest is a test class for testing the behavior of DSSendRegistriesItem
"
Class {
	#name : #DSSendRegistriesItemTest,
	#superclass : #DSSendItemTest,
	#category : 'Discord-Send-Items-Tests'
}

{ #category : #running }
DSSendRegistriesItemTest >> classToTest [
	^ DSSendRegistriesItem
]

{ #category : #tests }
DSSendRegistriesItemTest >> testRegistries [
	| registries |
	registries := DSRegistries twoWebhooksAndOneClient.
	item := self classToTest new.
	item registries: registries.
	self assert: item registries equals: registries.
]
