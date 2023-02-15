Class {
	#name : #DSShareInlinedMethodPartCommand,
	#superclass : #DSShareMethodCommand,
	#category : 'Discord-Integration-Calypso'
}

{ #category : #accessing }
DSShareInlinedMethodPartCommand >> userMessage [
	<return: #String>
	^ String streamContents: [ :aStream | 
		aStream
			space; 
			nextPutAll: (DSUtility smalltalkInlinedMarkdownOf: selectedText);
			cr; cr;
			nextPutAll: 'Extracted from ';
			nextPutAll: (DSUtility smalltalkInlinedMarkdownOf: self method printString) ]
]
