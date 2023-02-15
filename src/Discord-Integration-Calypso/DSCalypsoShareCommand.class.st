Class {
	#name : #DSCalypsoShareCommand,
	#superclass : #SycSourceCodeCommand,
	#instVars : [
		'selectedTextInterval',
		'selectedText',
		'browserMorph'
	],
	#category : 'Discord-Integration-Calypso'
}

{ #category : #accessing }
DSCalypsoShareCommand class >> defaultMenuItemName [
	^ 'Share on Discord'
]

{ #category : #activation }
DSCalypsoShareCommand class >> sourceCodeMenuActivation [
	<classAnnotation>
	
	^ SycSourceCodeMenuActivation byRootGroupItemFor: ClySourceCodeContext
]

{ #category : #accessing }
DSCalypsoShareCommand >> defaultMenuIcon [
	^ DSIcons discord 
]

{ #category : #execution }
DSCalypsoShareCommand >> execute [
	selectedText ifEmpty: [ ^ self shareWholeMethod ].
	selectedText lineCount > 1 
		ifTrue: [ self shareMultiLineText ]
		ifFalse: [ self shareInlinedText ]
]

{ #category : #execution }
DSCalypsoShareCommand >> readParametersFromContext: aSourceCodeContext [
	super readParametersFromContext: aSourceCodeContext.
	
	selectedTextInterval := aSourceCodeContext selectedTextInterval.
	selectedText := self method sourceCode 
			copyFrom: selectedTextInterval first 
			to: selectedTextInterval last.
	browserMorph := aSourceCodeContext browser window
]

{ #category : #private }
DSCalypsoShareCommand >> shareInlinedText [
	DSShareInlinedMethodPartCommand new
		method: method;
		sourceNode: sourceNode;
		selectedText: selectedText;
		selectedTextInterval: selectedTextInterval;
		morph: browserMorph;
		execute
]

{ #category : #'as yet unclassified' }
DSCalypsoShareCommand >> shareMultiLineText [
	DSShareMultiLineMethodPartCommand new
		method: method;
		sourceNode: sourceNode;
		selectedText: selectedText;
		selectedTextInterval: selectedTextInterval;
		morph: browserMorph;
		execute
]

{ #category : #private }
DSCalypsoShareCommand >> shareWholeMethod [
	DSShareWholeMethodCommand new
		method: method;
		sourceNode: sourceNode;
		selectedText: selectedText;
		selectedTextInterval: selectedTextInterval;
		morph: browserMorph;
		execute
]
