Class {
	#name : #DSMessagesElement,
	#superclass : #BlInfiniteElement,
	#category : 'Discord-UI-Brick'
}

{ #category : #initialization }
DSMessagesElement >> defaultLayout [
	^ BlInfiniteLinearLayout vertical
]

{ #category : #initialization }
DSMessagesElement >> initialize [
	super initialize.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
]
