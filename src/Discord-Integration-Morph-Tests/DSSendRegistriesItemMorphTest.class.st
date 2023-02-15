"
A DSSendRegistriesItemMorphTest is a test class for testing the behavior of DSSendRegistriesItemMorph
"
Class {
	#name : #DSSendRegistriesItemMorphTest,
	#superclass : #DSSendItemMorphTest,
	#category : 'Discord-Integration-Morph-Tests'
}

{ #category : #running }
DSSendRegistriesItemMorphTest >> classToTest [
	^ DSSendRegistriesItemMorph
]

{ #category : #running }
DSSendRegistriesItemMorphTest >> itemClassToTest [
	^ DSSendRegistriesItem
]

{ #category : #tests }
DSSendRegistriesItemMorphTest >> testItem [
	| item |
	item := self itemClassToTest twoWebhooksAndOneClient.
	morph := self classToTest new.
	morph item: item.
	self assert: morph submorphs first registries equals: item registries.
]

{ #category : #tests }
DSSendRegistriesItemMorphTest >> testSubmorphs [
	morph := self classToTest new.
	self assert: morph submorphs size equals: 2.
]
