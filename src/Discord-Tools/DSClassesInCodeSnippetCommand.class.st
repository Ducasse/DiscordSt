"
I receive a code snippet and I return a collection of classes written in the code snippet.
I exlude any globals that are not classes.

"
Class {
	#name : #DSClassesInCodeSnippetCommand,
	#superclass : #DSToolCommand,
	#instVars : [
		'codeSnippet',
		'classes'
	],
	#category : 'Discord-Tools-Commands'
}

{ #category : #accessing }
DSClassesInCodeSnippetCommand >> classes [
	^ classes
]

{ #category : #accessing }
DSClassesInCodeSnippetCommand >> classes: anObject [
	classes := anObject
]

{ #category : #accessing }
DSClassesInCodeSnippetCommand >> codeSnippet [
	^ codeSnippet
]

{ #category : #accessing }
DSClassesInCodeSnippetCommand >> codeSnippet: anObject [
	codeSnippet := anObject
]

{ #category : #execute }
DSClassesInCodeSnippetCommand >> execute [
	| ast |
	ast := Smalltalk compiler 
    source: self codeSnippet;
    parseExpression.
	classes := Array streamContents: [ :aStream | 
		ast nodesDo: [ :eachNode | 
			eachNode isVariable and: [ 
				Smalltalk environment at: eachNode name ifPresent: [ :aClass | 
					aClass isClass ifTrue: [ aStream nextPut: aClass ] ] ] ] ].
]
