Class {
	#name : #DSAnimatedGifScreenshot,
	#superclass : #DSScreenshot,
	#instVars : [
		'bytes',
		'recorder'
	],
	#category : 'Discord-Integration-Gif'
}

{ #category : #visitor }
DSAnimatedGifScreenshot >> accept: aVisitor [
	^ aVisitor visitDSAnimatedGifScreenshot: self
]

{ #category : #accessing }
DSAnimatedGifScreenshot >> bytes [
	^ recorder bytes
]

{ #category : #accessing }
DSAnimatedGifScreenshot >> form [
	"There is not preview for now"
	^ Form extent: 0@0 depth: 1
]

{ #category : #testing }
DSAnimatedGifScreenshot >> includes: anObject [ 
	"Return true if it is a screenshot of a given object"
	^ self bytes = anObject
]

{ #category : #initialization }
DSAnimatedGifScreenshot >> initialize [
	super initialize.
	recorder := DSAnimatedGifRecorder new.
]

{ #category : #accessing }
DSAnimatedGifScreenshot >> name [
	"Return a screenshot string representation, e.g., window name"
	^ 'Animated GIF'
]

{ #category : #actions }
DSAnimatedGifScreenshot >> nextRecoringAction [
	recorder nextAction
]

{ #category : #accessing }
DSAnimatedGifScreenshot >> recorder [
	^ recorder
]

{ #category : #ui }
DSAnimatedGifScreenshot >> recordingLabel [
	recorder isRecording ifTrue: [ ^ 'Stop Recording' ].
	recorder isRectangleRequested ifTrue: [ ^ 'Define Recording Area' ].
	recorder bytes ifNotNil: [ ^ 'Show' ].
	^ 'Start Recording'
]
