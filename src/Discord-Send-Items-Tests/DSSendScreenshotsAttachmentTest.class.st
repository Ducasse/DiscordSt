"
A DSSendScreenshotsAttachmentTest is a test class for testing the behavior of DSSendScreenshotsAttachment
"
Class {
	#name : #DSSendScreenshotsAttachmentTest,
	#superclass : #DSSendAttachmentTest,
	#category : 'Discord-Send-Items-Tests'
}

{ #category : #accessing }
DSSendScreenshotsAttachmentTest >> classToTest [
	^ DSSendScreenshotsAttachment
]

{ #category : #'tests-enumerating' }
DSSendScreenshotsAttachmentTest >> testOnContentChangedDo [
	| results |
	results := OrderedCollection new.
	attachment := self classToTest new.
	attachment onContentChangedDo: [ :announcement | results add: announcement ].
	attachment addMorph: Morph new.
	self assert: results size equals: 1.
	self assert: results first class equals: DSContentChangedAnnouncement.
]

{ #category : #'tests-accessing' }
DSSendScreenshotsAttachmentTest >> testScreenshots [
	attachment := self classToTest new.
	self assert: attachment screenshots isEmpty.
]
