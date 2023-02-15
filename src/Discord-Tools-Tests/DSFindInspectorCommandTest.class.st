"
A DSFindInspectorCommandTest is a test class for testing the behavior of DSFindInspectorCommand
"
Class {
	#name : #DSFindInspectorCommandTest,
	#superclass : #DSAbstractFindMorphCommandTest,
	#category : 'Discord-Tools-Tests-Commands'
}

{ #category : #running }
DSFindInspectorCommandTest >> classToTest [
	^ DSFindInspectorCommand
]

{ #category : #tests }
DSFindInspectorCommandTest >> testMorph [
	model := Object new.
	window := GTInspector openOn: model.
	command := self classToTest new.
	command model: model.
	result := command execute; morph.
	self assert: result == window.
]
