"
A DSSendInformationTest is a test class for testing the behavior of DSSendInformation
"
Class {
	#name : #DSSendInformationTest,
	#superclass : #TestCase,
	#instVars : [
		'info'
	],
	#category : 'Discord-Send-Items-Tests'
}

{ #category : #running }
DSSendInformationTest >> classToTest [
	^ DSSendInformation
]

{ #category : #tests }
DSSendInformationTest >> testDefaultIsSelected [
	info := self classToTest new.
	self assert: info isSelected.
	
]

{ #category : #tests }
DSSendInformationTest >> testDefaultName [
	info := self classToTest new.
	self assert: info name notNil.
	self assert: info name isString.
	
]

{ #category : #tests }
DSSendInformationTest >> testDefaultValue [
	info := self classToTest new.
	self assert: info value isNil.	
]

{ #category : #tests }
DSSendInformationTest >> testPrintString [
	info := self classToTest new.
	self assert: info printString isString.
]
