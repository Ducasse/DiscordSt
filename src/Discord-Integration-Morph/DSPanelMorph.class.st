Class {
	#name : #DSPanelMorph,
	#superclass : #PanelMorph,
	#category : 'Discord-Integration-Morph'
}

{ #category : #examples }
DSPanelMorph class >> basic [
	<gtExample>
	<label: 'Basic Example'>
	^ self new 
			extent: self initialExtent;
			yourself.
]

{ #category : #accessing }
DSPanelMorph class >> initialExtent [
	"Initial extent used in GT-Examples."
	^ 400@100
]

{ #category : #initialization }
DSPanelMorph >> defaultCellInset [
	^ 8
]

{ #category : #initialization }
DSPanelMorph >> defaultCellPositioning [
	^ #leftCenter
]

{ #category : #initialization }
DSPanelMorph >> defaultHorizontalResizing [
	^ #spaceFill
]

{ #category : #initialization }
DSPanelMorph >> defaultListDirection [
	^ #leftToRight
]

{ #category : #initialization }
DSPanelMorph >> defaultVerticalResizing [
	^ #spaceFill
]

{ #category : #initialization }
DSPanelMorph >> initialize [
	super initialize.
	self initializeLayout.
	
]

{ #category : #initialization }
DSPanelMorph >> initializeLayout [
	self
		fillStyle: Color transparent;
		cellInset: self defaultCellInset;
		changeTableLayout;
		listDirection: self defaultListDirection;
		hResizing: self defaultHorizontalResizing;
		vResizing: self defaultVerticalResizing;
		cellPositioning: self defaultCellPositioning
]

{ #category : #testing }
DSPanelMorph >> isAuthenticatedClientMorph [
	^ false
]

{ #category : #testing }
DSPanelMorph >> isClientLoginMorph [
	^ false
]

{ #category : #testing }
DSPanelMorph >> isWebhookMorph [
	^ false
]
