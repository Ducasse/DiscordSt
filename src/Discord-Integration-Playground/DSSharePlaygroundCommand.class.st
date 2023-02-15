Class {
	#name : #DSSharePlaygroundCommand,
	#superclass : #DSShareCommand,
	#instVars : [
		'playground'
	],
	#category : 'Discord-Integration-Playground'
}

{ #category : #private }
DSSharePlaygroundCommand >> addCodeSnippet: codeSnippet to: items [
	| item |
	item := items addCodeSnippetAttachment: codeSnippet.
	item 
		isSelected: self settingsClass  wasCodeSnippetSelected;
		onSelectionChangedDo: [ :announcement | 
			self settingsClass wasCodeSnippetSelected: announcement state ].
]

{ #category : #adding }
DSSharePlaygroundCommand >> addScreenshotTo: items [
	| morph |
	morph := DSFindPlaygroundCommand new model: self playground; execute; morph.
	self addMorphScreenshot: morph to: items.
]

{ #category : #private }
DSSharePlaygroundCommand >> addSourceCodeTo: items codeSnippet: codeSnippet [
	| classes packages item |
	classes := (DSClassesInCodeSnippetCommand new codeSnippet: codeSnippet; execute; classes).
	packages := (DSSortClassesPerPackageCommand new classes: classes; execute; packages).
	"Hack as it shares the whole package, we cannot select particular classes"
	packages do: [ :eachPackage | eachPackage classes: #(); isSelected: true ].
	item := items addPackagesAttachment: packages.
	item 
		isSelected: self settingsClass wasPackagesSelected;
		onSelectionChangedDo: [ :announcement | 
			self settingsClass wasPackagesSelected: announcement state ].
]

{ #category : #execute }
DSSharePlaygroundCommand >> execute [
	| items markdown codeSnippetCmd |
	items := DSSendItems new.
	codeSnippetCmd := DSExtractPlaygroundCodeSnippetCommand new playground: self playground; execute; yourself.
	markdown := codeSnippetCmd markdown.
	codeSnippetCmd hasCodeSnippet ifTrue: [ 
		items userTextMessageItem text: String cr, markdown ].
	self addScreenshotTo: items.
	codeSnippetCmd hasCodeSnippet ifTrue: [ 
		self addSourceCodeTo: items codeSnippet: codeSnippetCmd codeSnippet.
		self addCodeSnippet: codeSnippetCmd codeSnippet to: items ].
	items informationItem addPharoAndOsVersion.
	self initializeAttachmentsItem: items.
	DSSendDialogMorph new
		items: items;
		extent: 400@500;
		openInWindow
]

{ #category : #execute }
DSSharePlaygroundCommand >> executeAsync [
	^ self execute
]

{ #category : #private }
DSSharePlaygroundCommand >> initializeAttachmentsItem: items [
	items attachmentItem 
		isSelected: self settingsClass wasAttachmentsSelected;
		onSelectionChangedDo: [ :announcement | 
			self settingsClass wasAttachmentsSelected: announcement state ].
]

{ #category : #accessing }
DSSharePlaygroundCommand >> playground [
	^ playground
]

{ #category : #accessing }
DSSharePlaygroundCommand >> playground: anObject [
	playground := anObject
]

{ #category : #accessing }
DSSharePlaygroundCommand >> settingsClass [
	^ DSSharePlaygroundSettings
]
