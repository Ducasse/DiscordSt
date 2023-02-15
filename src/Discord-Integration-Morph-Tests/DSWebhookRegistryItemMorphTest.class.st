"
A DSWebhookRegistryItemMorphTest is a test class for testing the behavior of DSWebhookRegistryMorphItem
"
Class {
	#name : #DSWebhookRegistryItemMorphTest,
	#superclass : #TestCase,
	#instVars : [
		'morph',
		'window'
	],
	#category : 'Discord-Integration-Morph-Tests'
}

{ #category : #running }
DSWebhookRegistryItemMorphTest >> classToTest [
	^ DSRegistryItemMorph
]

{ #category : #running }
DSWebhookRegistryItemMorphTest >> tearDown [
	window ifNotNil: #delete.
	super tearDown.
]

{ #category : #tests }
DSWebhookRegistryItemMorphTest >> testDefault [
	morph := self classToTest new.
	window := morph openInWindow.
	self assert: window notNil.
]

{ #category : #tests }
DSWebhookRegistryItemMorphTest >> testRegistry [
	| registry |
	morph := self classToTest new.
	window := morph openInWindow.
	registry := DSWebhookRegistry developmentChannel.
	morph registry: registry.
	self assert: morph submorphs first form equals: registry icon.
	
]

{ #category : #tests }
DSWebhookRegistryItemMorphTest >> testRegistry2 [
	| registry |
	morph := self classToTest new.
	window := morph openInWindow.
	registry := DSWebhookRegistry developmentChannel.
	morph registry: registry.
	self assert: morph submorphs second contents equals: registry name.
	
]
