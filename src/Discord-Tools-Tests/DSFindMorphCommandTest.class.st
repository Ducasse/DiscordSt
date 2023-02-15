"
A DSFindMorphCommandTest is a test class for testing the behavior of DSFindMorphCommand
"
Class {
	#name : #DSFindMorphCommandTest,
	#superclass : #DSAbstractFindMorphCommandTest,
	#category : 'Discord-Tools-Tests-Commands'
}

{ #category : #running }
DSFindMorphCommandTest >> classToTest [
	^ DSFindMorphCommand
]

{ #category : #tests }
DSFindMorphCommandTest >> testMorph [
	model := Object new.
	morph := 'I am a test case' asMorph.
	window := morph openInWindow.
	command := self classToTest new.
	window model: model.
	command model: model.
	result := command execute; morph.
	self assert: result == window.
]
