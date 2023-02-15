"
A DSSendAttachmentTest is a test class for testing the behavior of DSSendAttachment
"
Class {
	#name : #DSSendAttachmentTest,
	#superclass : #TestCase,
	#instVars : [
		'attachment'
	],
	#category : 'Discord-Send-Items-Tests'
}

{ #category : #testing }
DSSendAttachmentTest class >> isAbstract [
	^ self name = #DSSendAttachmentTest
]

{ #category : #accessing }
DSSendAttachmentTest >> classToTest [
	^ self subclassResponsibility
]

{ #category : #tests }
DSSendAttachmentTest >> testAnnouncer [
	attachment := self classToTest new.
	self assert: attachment announcer notNil.
]

{ #category : #'tests-accessing' }
DSSendAttachmentTest >> testChildren [
	self assert: self classToTest new children isCollection.
]

{ #category : #'tests-accessing' }
DSSendAttachmentTest >> testEnabledChanged [
	| result |
	result := OrderedCollection new.
	attachment := self classToTest new.
	attachment onEnabledChangedDo: [ :announcement | 
		self assert: announcement object equals: attachment.
		result add: announcement ].
	attachment isEnabled: attachment isEnabled not.
	self assert: result size equals: 1.
	attachment isEnabled: attachment isEnabled.
	self assert: result size equals: 1.

]

{ #category : #'tests-accessing' }
DSSendAttachmentTest >> testIsEnabled [
	attachment := self classToTest new.
	self assert: (attachment isEnabled or: [ attachment isSelected not ])
]

{ #category : #'tests-accessing' }
DSSendAttachmentTest >> testIsSelected [
	attachment := self classToTest new.
	self assert: (attachment isSelected or: [ attachment isSelected not ])
]

{ #category : #'tests-accessing' }
DSSendAttachmentTest >> testPrintString [
	self assert: self classToTest new printString isString.
]

{ #category : #'tests-accessing' }
DSSendAttachmentTest >> testSelectionChanged [
	| result |
	result := OrderedCollection new.
	attachment := self classToTest new.
	attachment onSelectionChangedDo: [ :announcement | 
		self assert: announcement object = attachment.
		result add: announcement ].
	attachment isSelected: attachment isSelected not.
	self assert: result size equals: 1.
	attachment isSelected: attachment isSelected.
	self assert: result size equals: 1.
]
