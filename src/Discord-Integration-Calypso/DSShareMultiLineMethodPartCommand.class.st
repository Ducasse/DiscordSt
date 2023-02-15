Class {
	#name : #DSShareMultiLineMethodPartCommand,
	#superclass : #DSShareMethodCommand,
	#category : 'Discord-Integration-Calypso'
}

{ #category : #accessing }
DSShareMultiLineMethodPartCommand >> userMessage [
	<return: #String>
	^ String streamContents: [ :aStream | 
		aStream
			cr; 
			nextPutAll: (DSUtility smalltalkMarkdownOf: selectedText);
			cr;
			nextPutAll: 'Extracted from ';
			nextPutAll: (DSUtility smalltalkInlinedMarkdownOf: self method printString) ]
]
