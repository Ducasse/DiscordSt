Class {
	#name : #DSShareWholeMethodCommand,
	#superclass : #DSShareMethodCommand,
	#category : 'Discord-Integration-Calypso'
}

{ #category : #accessing }
DSShareWholeMethodCommand >> userMessage [
	<return: #String>
	^ String streamContents: [ :aStream | 
		aStream
			cr; 
			nextPutAll: (DSUtility smalltalkMarkdownOf: self method methodClass name asString, ' >> ', self method sourceCode) ]
]
