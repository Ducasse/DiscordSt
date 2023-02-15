"
A DSSendInformationItemMorphTest is a test class for testing the behavior of DSSendInformationItemMorph
"
Class {
	#name : #DSSendInformationItemMorphTest,
	#superclass : #DSSendItemMorphTest,
	#category : 'Discord-Integration-Morph-Tests'
}

{ #category : #running }
DSSendInformationItemMorphTest >> classToTest [
	^ DSSendInformationItemMorph
]

{ #category : #running }
DSSendInformationItemMorphTest >> itemClassToTest [
	^ DSSendInformationItem
]
