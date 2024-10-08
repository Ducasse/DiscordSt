Class {
	#name : #DSOpenTonelArchiveCommand,
	#superclass : #DSCommand,
	#instVars : [
		'bytes',
		'window'
	],
	#category : 'Discord-Integration-Core'
}

{ #category : #accessing }
DSOpenTonelArchiveCommand >> bytes [
	^ bytes
]

{ #category : #accessing }
DSOpenTonelArchiveCommand >> bytes: anObject [
	bytes := anObject
]

{ #category : #execute }
DSOpenTonelArchiveCommand >> execute [
	| repository inspector existingFileNames directory |
	existingFileNames := (FileLocator temp children) collect: #basename.
	directory := FileLocator temp / (DSGenerateFileNameCommand new 
			extension: '';
			existingFileNames: existingFileNames;
			execute;
			fileName).
	directory ensureCreateDirectory.
	ZipArchive new 
		readFrom: self bytes readStream;
		extractAllTo: directory.
	repository := TonelRepository new directory: directory.
	inspector := MCFileRepositoryInspector repository: repository workingCopy: nil.
	window := inspector show.
]

{ #category : #accessing }
DSOpenTonelArchiveCommand >> window [
	^ window
]
