"
I generate a unique file name.
The new file name has to be different from existingFileNames and includes extension.
I am useful for generating 'random' file names when it does not matter what file name is used.  
Public API and Key Messages

- extension: 			set file name extension (including dot)  
- existingFileNames	set a collection of existing file names
- fileName			new generated file name

Internal Representation and Key Implementation Points.

    Instance Variables
	existingFileNames:		<Array>
	extension:		<String>
	fileName:		<String>

"
Class {
	#name : #DSGenerateFileNameCommand,
	#superclass : #DSCommand,
	#instVars : [
		'extension',
		'existingFileNames',
		'fileName'
	],
	#category : 'Discord-Core-Commands'
}

{ #category : #execute }
DSGenerateFileNameCommand >> execute [
	| index |
	index := 0.
	[ 
		self fileName: (String streamContents: [ :aStream |
			self identityHash printOn:aStream.
			aStream << '-'.
			(existingFileNames size + 1 + index) printOn: aStream. 
			extension printOn: aStream ]).
		index := index + 1.
		self existingFileNames anySatisfy: [ :eachFileName | eachFileName = self fileName ]
	] whileTrue
]

{ #category : #accessing }
DSGenerateFileNameCommand >> existingFileNames [
	^ existingFileNames
]

{ #category : #accessing }
DSGenerateFileNameCommand >> existingFileNames: anObject [
	existingFileNames := anObject
]

{ #category : #accessing }
DSGenerateFileNameCommand >> extension [
	^ extension
]

{ #category : #accessing }
DSGenerateFileNameCommand >> extension: anObject [
	extension := anObject
]

{ #category : #accessing }
DSGenerateFileNameCommand >> fileName [
	^ fileName
]

{ #category : #accessing }
DSGenerateFileNameCommand >> fileName: anObject [
	fileName := anObject
]

{ #category : #initialization }
DSGenerateFileNameCommand >> initialize [
	super initialize.
	extension := '.png'.
	existingFileNames := #().
]
