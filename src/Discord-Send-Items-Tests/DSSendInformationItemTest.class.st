"
A DSSendInformationItemTest is a test class for testing the behavior of DSSendInformationItem
"
Class {
	#name : #DSSendInformationItemTest,
	#superclass : #DSSendItemTest,
	#category : 'Discord-Send-Items-Tests'
}

{ #category : #running }
DSSendInformationItemTest >> classToTest [
	^ DSSendInformationItem
]

{ #category : #tests }
DSSendInformationItemTest >> testAddNameValue [
	item := self classToTest new.
	item addName: 'test name' value: 'test value'.
	self assert: item infos size equals: 1.
	self assert: item infos first name equals: 'test name'.
	self assert: item infos first value equals: 'test value'.
	
]

{ #category : #tests }
DSSendInformationItemTest >> testInfos [
	item := self classToTest new.
	self assert: item infos notNil.
	self assert: item infos isEmpty.
	
]

{ #category : #tests }
DSSendInformationItemTest >> testWithPharoAndOsVersion [
	item := self classToTest withPharoAndOsVersion.
	self assert: item infos size equals: 2.
	self assert: item infos first name equals: 'Pharo'.
	self assert: item infos second name equals: 'OS'.
	
]
