"
A DSSendAttachmentsMorphTest is a test class for testing the behavior of DSSendAttachmentsMorph
"
Class {
	#name : #DSSendAttachmentsItemMorphTest,
	#superclass : #DSSendItemMorphTest,
	#category : 'Discord-Integration-Morph-Tests'
}

{ #category : #accessing }
DSSendAttachmentsItemMorphTest >> classToTest [
	^ DSSendAttachmentsItemMorph
]

{ #category : #running }
DSSendAttachmentsItemMorphTest >> itemClassToTest [
	<return: #DSSentItem>
	^ DSSendAttachmentsItem
]

{ #category : #'tests-examples' }
DSSendAttachmentsItemMorphTest >> testScreenshotsAndPackages [
	morph := self classToTest screenshotsAndPackages.
	self assert: morph submorphs first numberOfRows equals: 10.
]

{ #category : #tests }
DSSendAttachmentsItemMorphTest >> testSubmorphs [
	morph := self classToTest new.
	self assert: morph submorphs size equals: 1.
]
