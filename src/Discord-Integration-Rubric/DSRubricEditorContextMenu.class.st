Class {
	#name : #DSRubricEditorContextMenu,
	#superclass : #Object,
	#instVars : [
		'editorMorph',
		'editorModel',
		'selection',
		'selectedText',
		'menuItem',
		'wholeText'
	],
	#category : 'Discord-Integration-Rubric'
}

{ #category : #menus }
DSRubricEditorContextMenu class >> menuFor: aBuilder [
	<contextMenu>
	<RubSmalltalkCodeMenu>
	^ self new
		menuFor: aBuilder
		yourself
]

{ #category : #menus }
DSRubricEditorContextMenu >> menuFor: aBuilder [
	editorMorph := aBuilder model ifNil: [ ^ self ].
	editorModel := editorMorph model ifNil: [ ^ self ].
	wholeText := editorMorph dsGetString.
	selection := editorMorph selectionInterval.
	self assert: selection notNil.
	selectedText := wholeText copyFrom: selection first to: selection last.
	self assert: selectedText notNil.
	self shouldBeExcluded ifTrue: [ ^ self ].
	menuItem := aBuilder item: 'Share on Discord'.
	menuItem action: [ self shareOnDiscord ].
	menuItem icon: DSIcons discord.
	menuItem order: 8.
]

{ #category : #private }
DSRubricEditorContextMenu >> shareOnDiscord [
	DSShareTextCommand new
		wholeText: wholeText;
		selectedText: selectedText;
		selectedTextInterval: selection;
		morph: editorMorph window;
		execute
]

{ #category : #testing }
DSRubricEditorContextMenu >> shouldBeExcluded [
	^ (Pragma allNamed: #excludeShareOnDiscord in: self class) anySatisfy: [ :eachPragma | 
			self perform: eachPragma selector ]
]
