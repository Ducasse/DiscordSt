Class {
	#name : #DSSharedTonel,
	#superclass : #DSSharedData,
	#instVars : [
		'bytes'
	],
	#category : 'Discord-Send-Items'
}

{ #category : #accessing }
DSSharedTonel class >> typeName [
	"Return a string data representation.
	It should be a short string including only [a-z] characters."
	<return: #String>
	^ #tonel
]

{ #category : #visiting }
DSSharedTonel >> accept: aVisitor [
	^ aVisitor visitDSSharedTonel: self
]

{ #category : #accessing }
DSSharedTonel >> bytes [
	^ bytes
]

{ #category : #accessing }
DSSharedTonel >> contents: aByteArray [ 
	"The byte array should be a ZIP file that includes Tonel Monticello format."
	bytes := aByteArray
]
