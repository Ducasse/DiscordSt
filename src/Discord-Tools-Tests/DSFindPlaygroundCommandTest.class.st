"
A DSFindPlaygroundCommandTest is a test class for testing the behavior of DSFindPlaygroundCommand
"
Class {
	#name : #DSFindPlaygroundCommandTest,
	#superclass : #DSAbstractFindMorphCommandTest,
	#category : 'Discord-Tools-Tests-Commands'
}

{ #category : #running }
DSFindPlaygroundCommandTest >> classToTest [
	^ DSFindPlaygroundCommand
]

{ #category : #tests }
DSFindPlaygroundCommandTest >> testMorph [
	| script page |
	model := Object new.
	script := 'World submorphs'.
	page := GTPlayPage new saveContent: script; yourself.
	window := GTPlayground openOn: page.
	(window model presentations first panes flatCollect: #presentations) 
			first selection: model.
	command := self classToTest new.
	command model: model.
	result := command execute; morph.
	self assert: result == window.
]

{ #category : #tests }
DSFindPlaygroundCommandTest >> testMorph2 [
	"Search for a specific playground."
	| script page |
	script := 'World submorphs'.
	page := GTPlayPage new saveContent: script; yourself.
	model := GTPlayground new.
	window := model openOn: page.
	command := self classToTest new.
	command model: model.
	result := command execute; morph.
	self assert: result == window.
]
