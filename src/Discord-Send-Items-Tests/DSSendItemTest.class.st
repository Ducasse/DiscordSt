"
A DSSendItemTest is a test class for testing the behavior of DSSendItem
"
Class {
	#name : #DSSendItemTest,
	#superclass : #TestCase,
	#instVars : [
		'item'
	],
	#category : 'Discord-Send-Items-Tests'
}

{ #category : #testing }
DSSendItemTest class >> isAbstract [
	^ self name = #DSSendItemTest
]

{ #category : #running }
DSSendItemTest >> classToTest [
	^ self subclassResponsibility
]

{ #category : #tests }
DSSendItemTest >> testAnnouncer [
	item := self classToTest new.
	self assert: item announcer notNil.
]

{ #category : #tests }
DSSendItemTest >> testDefaultPriority [
	item := self classToTest new.
	self assert: item priority equals: item defaultPriority.
]
