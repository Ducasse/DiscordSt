"
A DSConnectionRegistryTest is a test class for testing the behavior of DSConnectionRegistry
"
Class {
	#name : #DSConnectionRegistryTest,
	#superclass : #TestCase,
	#instVars : [
		'registry'
	],
	#category : 'Discord-Registry-Core-Tests'
}

{ #category : #testing }
DSConnectionRegistryTest class >> isAbstract [
	^ self name = #DSConnectionRegistryTest
]

{ #category : #running }
DSConnectionRegistryTest >> classToTest [
	^ self subclassResponsibility
]

{ #category : #tests }
DSConnectionRegistryTest >> testIcon [
	| icon |
	icon := Smalltalk ui icons iconNamed: #class.
	registry := self classToTest new.
	registry icon: icon.
	self assert: registry icon equals: icon.
]
