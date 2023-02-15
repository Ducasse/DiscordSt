"
A DSSendAttachmentsItemTest is a test class for testing the behavior of DSSendAttachmentsItem
"
Class {
	#name : #DSSendAttachmentsItemTest,
	#superclass : #DSSendItemTest,
	#category : 'Discord-Send-Items-Tests'
}

{ #category : #accessing }
DSSendAttachmentsItemTest >> classToTest [
	^ DSSendAttachmentsItem
]

{ #category : #'tests-adding' }
DSSendAttachmentsItemTest >> testAddMorphScreenshot [
	| morph |
	morph := Morph new.
	item := self classToTest new.
	item addMorphScreenshot: morph.
	self assert: item attachments size equals: 1.
	self assert: item attachments first screenshots size equals: 1.
	self assert: item attachments first screenshots first morph equals: morph.
]
