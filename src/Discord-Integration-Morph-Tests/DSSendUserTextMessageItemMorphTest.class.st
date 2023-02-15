"
A DSSendUserTextMessageItemMorphTest is a test class for testing the behavior of DSSendUserTextMessageItemMorph
"
Class {
	#name : #DSSendUserTextMessageItemMorphTest,
	#superclass : #DSSendItemMorphTest,
	#category : 'Discord-Integration-Morph-Tests'
}

{ #category : #running }
DSSendUserTextMessageItemMorphTest >> classToTest [
	^ DSSendUserTextMessageItemMorph
]

{ #category : #running }
DSSendUserTextMessageItemMorphTest >> itemClassToTest [
	^ DSSendUserTextMessageItem
]

{ #category : #tests }
DSSendUserTextMessageItemMorphTest >> testItem2 [
	| item |
	item := self itemClassToTest loremIpsum.
	morph := self classToTest new.
	morph item: item.
	self assert: morph textModel getString equals: item text.
]

{ #category : #tests }
DSSendUserTextMessageItemMorphTest >> testItem3 [
	| item |
	item := self itemClassToTest new.
	morph := self classToTest new.
	morph item: item.
	self assert: morph textModel getString isEmpty.
	morph textModel setText: 'message'.
	self assert: item text equals: 'message'.
]

{ #category : #tests }
DSSendUserTextMessageItemMorphTest >> testSubmorphs [
	morph := self classToTest new.
	self assert: morph submorphs size equals: 1.
]

{ #category : #tests }
DSSendUserTextMessageItemMorphTest >> testTextModel [
	morph := self classToTest new.
	self assert: morph textModel getString isEmpty.
]
