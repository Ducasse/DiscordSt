"
A DSSelectionTest is a test class for testing the behavior of DSSelection
"
Class {
	#name : #DSSelectionTest,
	#superclass : #TestCase,
	#instVars : [
		'selection'
	],
	#category : 'Discord-Tools-Tests-Support'
}

{ #category : #testing }
DSSelectionTest class >> isAbstract [
	^ self name = #DSSelectionTest 
]

{ #category : #running }
DSSelectionTest >> classToTest [
	^ self subclassResponsibility
]

{ #category : #tests }
DSSelectionTest >> testEnabledChanged [
	| result |
	selection := self classToTest new.
	selection onEnabledChangedDo: [ :ann | result := ann ].
	selection isEnabled: false.
	self assert: result notNil.
	self assert: result class equals: DSEnabledChangedAnnouncement.
	self assert: result object equals: selection.
	self deny: result state.
	
]

{ #category : #tests }
DSSelectionTest >> testEnabledChangedIgnored [
	| result |
	selection := self classToTest new.
	selection isEnabled: false.
	selection onSelectionChangedDo: [ :ann | result := ann ].
	selection isEnabled: false.
	self assert: result isNil.
	
]

{ #category : #tests }
DSSelectionTest >> testEnabledChangedToTrue [
	| result |
	selection := self classToTest new.
	selection isEnabled: false.
	selection onEnabledChangedDo: [ :ann | result := ann ].
	selection isEnabled: true.
	self assert: result notNil.
	self assert: result class equals: DSEnabledChangedAnnouncement.
	self assert: result object equals: selection.
	self assert: result state.
	
]

{ #category : #tests }
DSSelectionTest >> testIsEnabled [
	selection := self classToTest new.
	selection isEnabled: true.
	self assert: selection isEnabled.
]

{ #category : #tests }
DSSelectionTest >> testIsEnabledDefault [
	selection := self classToTest new.
	self assert: selection isEnabled
]

{ #category : #tests }
DSSelectionTest >> testIsSelected [
	selection := self classToTest new.
	selection isSelected: true.
	self assert: selection isSelected.
]

{ #category : #tests }
DSSelectionTest >> testIsSelectedDefault [
	selection := self classToTest new.
	self deny: selection isSelected
]

{ #category : #tests }
DSSelectionTest >> testSelectionChanged [
	| result |
	selection := self classToTest new.
	selection onSelectionChangedDo: [ :ann | result := ann ].
	selection isSelected: true.
	self assert: result notNil.
	self assert: result class equals: DSSelectionChangedAnnouncement.
	self assert: result object equals: selection.
	self assert: result state.
	
]

{ #category : #tests }
DSSelectionTest >> testSelectionChangedDeselected [
	| result |
	selection := self classToTest new.
	selection isSelected: true.
	selection onSelectionChangedDo: [ :ann | result := ann ].
	selection isSelected: false.
	self assert: result notNil.
	self assert: result class equals: DSSelectionChangedAnnouncement.
	self assert: result object equals: selection.
	self deny: result state.
	
]

{ #category : #tests }
DSSelectionTest >> testSelectionChangedIgnored [
	| result |
	selection := self classToTest new.
	selection isSelected: true.
	selection onSelectionChangedDo: [ :ann | result := ann ].
	selection isSelected: true.
	self assert: result isNil.
	
]
