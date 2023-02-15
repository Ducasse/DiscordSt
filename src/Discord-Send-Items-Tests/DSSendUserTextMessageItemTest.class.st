"
A DSSendUserTextMessageItemTest is a test class for testing the behavior of DSSendUserTextMessageItem
"
Class {
	#name : #DSSendUserTextMessageItemTest,
	#superclass : #DSSendItemTest,
	#category : 'Discord-Send-Items-Tests'
}

{ #category : #running }
DSSendUserTextMessageItemTest >> classToTest [
	^ DSSendUserTextMessageItem
]

{ #category : #tests }
DSSendUserTextMessageItemTest >> testItemContentChanged [
	| result |
	item := self classToTest new.
	item onContentChangedDo: [ :ann | result := ann ].
	item text: 'message'.
	self assert: result notNil.
	self assert: result class equals: DSContentChangedAnnouncement.
]

{ #category : #tests }
DSSendUserTextMessageItemTest >> testText [
	item := self classToTest new.
	item text: 'message'.
	self assert: item text equals: 'message'.
]

{ #category : #tests }
DSSendUserTextMessageItemTest >> testTextDefault [
	item := self classToTest new.
	self assert: item text isEmpty.
]
