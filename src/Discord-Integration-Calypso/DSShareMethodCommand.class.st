Class {
	#name : #DSShareMethodCommand,
	#superclass : #DSShareTextCommand,
	#instVars : [
		'method',
		'sourceNode'
	],
	#category : 'Discord-Integration-Calypso'
}

{ #category : #testing }
DSShareMethodCommand class >> isAbstract [
	^ self name = #DSShareMethodCommand 
]

{ #category : #accessing }
DSShareMethodCommand >> method [
	^ method
]

{ #category : #accessing }
DSShareMethodCommand >> method: anObject [
	method := anObject
]

{ #category : #accessing }
DSShareMethodCommand >> sourceNode [
	^ sourceNode
]

{ #category : #accessing }
DSShareMethodCommand >> sourceNode: anObject [
	sourceNode := anObject
]

{ #category : #accessing }
DSShareMethodCommand >> userMessage [
	"Return a predefined user message"
	<return: #String>
	^ self subclassResponsibility
]
