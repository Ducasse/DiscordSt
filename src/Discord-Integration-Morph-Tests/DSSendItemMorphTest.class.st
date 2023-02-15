"
A DSSendItemMorphTest is a test class for testing the behavior of DSSendItemMorph
"
Class {
	#name : #DSSendItemMorphTest,
	#superclass : #TestCase,
	#instVars : [
		'morph'
	],
	#category : 'Discord-Integration-Morph-Tests'
}

{ #category : #testing }
DSSendItemMorphTest class >> isAbstract [
	^ self name = #DSSendItemMorphTest 
]

{ #category : #running }
DSSendItemMorphTest >> classToTest [
	<return: #DSSendItemMorph>
	^ self subclassResponsibility
]

{ #category : #running }
DSSendItemMorphTest >> itemClassToTest [
	<return: #DSSentItem>
	^ self subclassResponsibility
]

{ #category : #tests }
DSSendItemMorphTest >> testItem [
	| item |
	morph := self classToTest new.
	item := self itemClassToTest new.
	morph item: item.
	self assert: morph item equals: item.
]

{ #category : #tests }
DSSendItemMorphTest >> testItemDefault [
	morph := self classToTest new.
	self assert: morph item notNil.
]
