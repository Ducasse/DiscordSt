"
A DSFindInspectorPaneCommandTest is a test class for testing the behavior of DSFindInspectorPaneCommand
"
Class {
	#name : #DSFindInspectorPaneCommandTest,
	#superclass : #DSAbstractFindMorphCommandTest,
	#category : 'Discord-Tools-Tests-Commands'
}

{ #category : #running }
DSFindInspectorPaneCommandTest >> classToTest [
	^ DSFindInspectorPaneCommand 
]

{ #category : #tests }
DSFindInspectorPaneCommandTest >> testMorph [
	model := Object new.
	window := GTInspector openOn: Morph new.
	(window model panes flatCollect: #presentations) 
			first selection: model.
	command := self classToTest new.
	command model: model.
	result := command execute; morph.
	self assert: result == window.
]
