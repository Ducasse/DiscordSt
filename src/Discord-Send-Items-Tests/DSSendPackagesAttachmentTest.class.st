"
A DSSendPackagesAttachmentTest is a test class for testing the behavior of DSSendPackagesAttachment
"
Class {
	#name : #DSSendPackagesAttachmentTest,
	#superclass : #DSSendAttachmentTest,
	#category : 'Discord-Send-Items-Tests'
}

{ #category : #accessing }
DSSendPackagesAttachmentTest >> classToTest [
	^ DSSendPackagesAttachment
]

{ #category : #tests }
DSSendPackagesAttachmentTest >> testPackages [
	| collection |
	collection := DSPackages new.
	attachment := self classToTest new.
	attachment packages: collection.
	self assert: attachment packages equals: collection.
]

{ #category : #tests }
DSSendPackagesAttachmentTest >> testPackagesDefault [
	attachment := self classToTest new.
	self assert: attachment packages isEmpty.
]
