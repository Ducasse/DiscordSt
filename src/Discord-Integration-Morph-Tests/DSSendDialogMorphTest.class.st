"
A DSSendDialogMorphTest is a test class for testing the behavior of DSSendDialogMorph
"
Class {
	#name : #DSSendDialogMorphTest,
	#superclass : #TestCase,
	#instVars : [
		'morph'
	],
	#category : 'Discord-Integration-Morph-Tests'
}

{ #category : #running }
DSSendDialogMorphTest >> classToTest [
	^ DSSendDialogMorph
]

{ #category : #tests }
DSSendDialogMorphTest >> testItems [
	morph := self classToTest new.
	morph items: DSSendItems new.
	self assert: morph submorphs first class equals: DSSendUserTextMessageItemMorph.
]

{ #category : #tests }
DSSendDialogMorphTest >> testSubmorphsOrder [
	morph := self classToTest textScreenshotsAndRegistries.
	self assert: morph submorphs size equals: 3.
	self assert: morph submorphs first class equals: DSSendUserTextMessageItemMorph.
	self assert: morph submorphs second class equals: DSSendAttachmentsItemMorph.
	self assert: morph submorphs third class equals: DSSendRegistriesItemMorph.
]
