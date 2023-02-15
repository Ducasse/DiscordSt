"
I am an abstract command.
My subclasses search for a Morph (window) that represents a given model.
"
Class {
	#name : #DSAbstractFindMorphCommand,
	#superclass : #DSToolCommand,
	#instVars : [
		'model',
		'morph'
	],
	#category : 'Discord-Tools-Commands'
}

{ #category : #execute }
DSAbstractFindMorphCommand >> execute [
	^ self subclassResponsibility
]

{ #category : #accessing }
DSAbstractFindMorphCommand >> model [
	^ model
]

{ #category : #accessing }
DSAbstractFindMorphCommand >> model: anObject [
	model := anObject
]

{ #category : #accessing }
DSAbstractFindMorphCommand >> morph [
	^ morph
]

{ #category : #accessing }
DSAbstractFindMorphCommand >> morph: anObject [
	morph := anObject
]
