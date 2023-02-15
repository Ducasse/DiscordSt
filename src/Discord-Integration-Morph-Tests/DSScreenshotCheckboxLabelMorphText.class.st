"
A DSScreenshotItemLabelMorphTest is a test class for testing the behavior of DSScreenshotItemLabelMorph
"
Class {
	#name : #DSScreenshotCheckboxLabelMorphText,
	#superclass : #TestCase,
	#instVars : [
		'morph',
		'window'
	],
	#category : 'Discord-Integration-Morph-Tests'
}

{ #category : #running }
DSScreenshotCheckboxLabelMorphText >> classToTest [
	^ DSScreenshotCheckboxLabelMorph
]

{ #category : #running }
DSScreenshotCheckboxLabelMorphText >> tearDown [
	super tearDown.
	window ifNotNil: #delete.
]

{ #category : #tests }
DSScreenshotCheckboxLabelMorphText >> testShowPreview [
	| model |
	morph := self classToTest new.
	model := World submorphs atRandom.
	morph
		model: model;
		getTextSelector: #printString;
		getFormSelector: #imageForm.
	window := morph openInWindow.
	morph simulateClick.
	morph showPreview.
	self assert: window notNil.
]

{ #category : #tests }
DSScreenshotCheckboxLabelMorphText >> testShowPreviewDefault [
	morph := self classToTest new.
	window := morph openInWindow.
	morph simulateClick.
	self assert: window notNil.
]
