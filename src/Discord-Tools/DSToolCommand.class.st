"
I am an abstract tool command.
"
Class {
	#name : #DSToolCommand,
	#superclass : #Object,
	#category : 'Discord-Tools-Commands'
}

{ #category : #execute }
DSToolCommand >> execute [
	^ self subclassResponsibility
]
