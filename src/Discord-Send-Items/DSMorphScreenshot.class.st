Class {
	#name : #DSMorphScreenshot,
	#superclass : #DSScreenshot,
	#instVars : [
		'morph'
	],
	#category : 'Discord-Send-Items'
}

{ #category : #'as yet unclassified' }
DSMorphScreenshot class >> friendlyNameFor: aMorph [
	"Return a screenshot string representation, e.g., window name"
	<return: #String>
	^ aMorph
		ifNotNil: [ :theMorph | theMorph isSystemWindow 
			ifTrue: [ theMorph label ]  
			ifFalse: [ theMorph printString ] ]
		ifNil: 'without screenshot'
]

{ #category : #visitor }
DSMorphScreenshot >> accept: aVisitor [
	^ aVisitor visitDSMorphScreenshot: self
]

{ #category : #accessing }
DSMorphScreenshot >> form [
	"Return a screenshot Form representation"
	<return: #Form>
	^ self morph imageForm
]

{ #category : #'gt-inspector-extension' }
DSMorphScreenshot >> gtInspectorMorphIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite morph
		title: [ 'Morph' translated ];
		display: [ self morph imageForm ];
		when: [ self morph notNil ];
		yourself
]

{ #category : #testing }
DSMorphScreenshot >> includes: anObject [ 
	^ self morph = anObject
]

{ #category : #accessing }
DSMorphScreenshot >> morph [
	^ morph
]

{ #category : #accessing }
DSMorphScreenshot >> morph: anObject [
	morph := anObject
]

{ #category : #accessing }
DSMorphScreenshot >> name [
	"Return a screenshot string representation, e.g., window name"
	<return: #String>
	^ self morph 
		ifNotNil: [ :aMorph | aMorph isSystemWindow 
			ifTrue: [ aMorph label ]  
			ifFalse: [ aMorph printString ] ]
		ifNil: 'without screenshot'
]
