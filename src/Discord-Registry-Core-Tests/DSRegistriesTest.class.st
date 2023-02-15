"
A DSRegistriesTest is a test class for testing the behavior of DSRegistries
"
Class {
	#name : #DSRegistriesTest,
	#superclass : #TestCase,
	#instVars : [
		'registries'
	],
	#category : 'Discord-Registry-Core-Tests'
}

{ #category : #running }
DSRegistriesTest >> classToTest [
	^ DSRegistries
]

{ #category : #tests }
DSRegistriesTest >> testOnSelectionChangedDo [
	| result |
	registries := self classToTest twoWebhooksAndOneClient.
	registries onSelectionChangedDo: [ :ann | result := ann ].
	registries selection: registries first.
	self assert: result class equals: DSRegistrySelectionChangedAnnouncement.
	self assert: result registries equals: registries.
	self assert: result selection equals: registries selection.
]

{ #category : #tests }
DSRegistriesTest >> testSelection [
	registries := self classToTest twoWebhooksAndOneClient.
	registries selection: registries first.
	self assert: registries selection equals: registries first.
]
