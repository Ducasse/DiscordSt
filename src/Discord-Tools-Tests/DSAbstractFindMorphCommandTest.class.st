"
A DSFindMorphCommandTest is a test class for testing the behavior of DSFindMorphCommand
"
Class {
	#name : #DSAbstractFindMorphCommandTest,
	#superclass : #DSToolCommandTest,
	#instVars : [
		'model',
		'morph',
		'window',
		'command',
		'result'
	],
	#category : 'Discord-Tools-Tests-Commands'
}

{ #category : #testing }
DSAbstractFindMorphCommandTest class >> isAbstract [
	^ self name = #DSAbstractFindMorphCommandTest 
]

{ #category : #running }
DSAbstractFindMorphCommandTest >> tearDown [
	window ifNotNil: #delete.
	super tearDown.
]

{ #category : #tests }
DSAbstractFindMorphCommandTest >> testMorph [
	self subclassResponsibility
]
