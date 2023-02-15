"
I represent a label morph that displays a Form preview on mouse enter.
I am used by DSScreenshotMorph.
See examples on the class side.
"
Class {
	#name : #DSScreenshotCheckboxLabelMorph,
	#superclass : #LabelMorph,
	#instVars : [
		'getFormSelector'
	],
	#category : 'Discord-Integration-Morph'
}

{ #category : #examples }
DSScreenshotCheckboxLabelMorph class >> basic [
	<gtExample>
	<label: 'Basic usage'>
	| morph |
	morph := World submorphs atRandom.
	^ self new
		model: morph;
		getTextSelector: #printString;
		getFormSelector: #imageForm;
		hResizing: #spaceFill; 
		vResizing: #shrinkWrap; 
		yourself
]

{ #category : #examples }
DSScreenshotCheckboxLabelMorph class >> basicInWindow [
	<example>
	^ self basic openInWindow
]

{ #category : #accessing }
DSScreenshotCheckboxLabelMorph >> form [
	"Return a Form that should be previewed.
	If there is not a Form to preview, return nil."
	<return: #form or: nil>
	^ self getFormSelector 
		ifNotNil: [ self model perform: self getFormSelector ]
]

{ #category : #accessing }
DSScreenshotCheckboxLabelMorph >> getFormSelector [
	"Return a message name that is sent to a model when a preview is requested."
	<return: #Symbol>
	^ getFormSelector
]

{ #category : #accessing }
DSScreenshotCheckboxLabelMorph >> getFormSelector: aSymbol [
	"Set a selector that is sent to a model when a preview is requested."
	getFormSelector := aSymbol
]

{ #category : #'event handling' }
DSScreenshotCheckboxLabelMorph >> handlesMouseOver: anEvent [
	"Return true if there is a Morph to preview; false otherwise."
	<return: #Boolean>
	^ self hasScreenshot
]

{ #category : #testing }
DSScreenshotCheckboxLabelMorph >> hasScreenshot [
	"Return true if an object (morph) to preview is really the Morph object."
	<return: #Boolean>
	^ self form isForm
]

{ #category : #'event handling' }
DSScreenshotCheckboxLabelMorph >> mouseEnter: anEvent [
	self showPreview.
]

{ #category : #'event handling' }
DSScreenshotCheckboxLabelMorph >> showPreview [	
	"Pop up a balloon containing the given preview,
	first removing any existing BalloonMorphs in the world."
	| vertices aWorld aHand worldBounds preview |
	(aWorld := self world) ifNil: [^self].
	aHand := aWorld activeHand.
	preview := ImagePreviewMorph new
		image: self form size: 150@150;
		yourself.
	preview fullBounds.
	vertices := SimpleBalloonMorph getVertices: preview bounds.
	vertices := SimpleBalloonMorph
				getBestLocation: vertices
				for: self
				corner: #topLeft.
	preview position: vertices first.
	preview lock.
	preview setProperty: #morphicLayerNumber toValue: preview morphicLayerNumber.
	aHand world addMorphFront: preview.
	((worldBounds := aHand world bounds) containsRect: preview bounds) ifFalse:
		[preview bounds: (preview bounds translatedToBeWithin: worldBounds)].
	aHand balloonHelp: preview.
]
