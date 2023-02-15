"
A DSSendItemsTest is a test class for testing the behavior of DSSendItems
"
Class {
	#name : #DSSendItemsTest,
	#superclass : #TestCase,
	#instVars : [
		'items'
	],
	#category : 'Discord-Send-Items-Tests'
}

{ #category : #running }
DSSendItemsTest >> classToTest [
	^ DSSendItems
]

{ #category : #tests }
DSSendItemsTest >> testCollectionDefault [
	items := self classToTest new.
	self assert: items collection size equals: items defaultCollection size.
]
