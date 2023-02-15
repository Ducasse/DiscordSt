Class {
	#name : #DSSharedData,
	#superclass : #Object,
	#instVars : [
		'fileName',
		'url'
	],
	#category : 'Discord-Send-Items'
}

{ #category : #'instance creation' }
DSSharedData class >> newCodeSnippet [
	^ DSSharedCodeSnippet new
]

{ #category : #'instance creation' }
DSSharedData class >> newTonel [
	^ DSSharedTonel new
]

{ #category : #'instance creation' }
DSSharedData class >> ofType: aString [ 
	self allSubclassesDo: [ :eachSubclass | 
		eachSubclass typeName = aString ifTrue: [ ^ eachSubclass new ] ].
	self error: 'Unknown type. It should not happen.'.
]

{ #category : #accessing }
DSSharedData class >> typeName [
	"Return a string data representation.
	It should be a short string including only [a-z] characters."
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #visiting }
DSSharedData >> accept: aVisitor [
	^ self subclassResponsibility
]

{ #category : #accessing }
DSSharedData >> contents: aByteArray [
	"It receives a byte array.
	Each data object is responsible to convert it to a meaningful object, e.g., code snippet (string)."
	^ self subclassResponsibility
]

{ #category : #accessing }
DSSharedData >> fileName [
	^ fileName
]

{ #category : #accessing }
DSSharedData >> fileName: anObject [
	fileName := anObject
]

{ #category : #testing }
DSSharedData >> isCodeSnippet [
	^ false
]

{ #category : #printing }
DSSharedData >> printOn: aStream [
	aStream 
		nextPutAll: 'Type: '; print: self type;
		nextPutAll: ' fileName: '; print: self fileName.
	self url 
		ifNil: [ aStream nextPutAll: ' without an URL' ]
		ifNotNil: [ aStream nextPutAll: ' with an URL' ]
]

{ #category : #accessing }
DSSharedData >> type [
	^ self class typeName
]

{ #category : #accessing }
DSSharedData >> url [
	^ url
]

{ #category : #accessing }
DSSharedData >> url: anObject [
	url := anObject
]
