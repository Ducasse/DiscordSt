Class {
	#name : #DSShareSettings,
	#superclass : #Object,
	#classInstVars : [
		'wasScreenshotsSelected',
		'wasAttachmentsSelected',
		'wasCodeSnippetSelected',
		'wasPackagesSelected'
	],
	#category : 'Discord-Integration-Core'
}

{ #category : #accessing }
DSShareSettings class >> wasAttachmentsSelected [
	^ wasAttachmentsSelected ifNil: [ wasAttachmentsSelected := true ]
]

{ #category : #accessing }
DSShareSettings class >> wasAttachmentsSelected: aBoolean [ 
	wasAttachmentsSelected := aBoolean
]

{ #category : #accessing }
DSShareSettings class >> wasCodeSnippetSelected [
	^ wasCodeSnippetSelected ifNil: [ wasCodeSnippetSelected := true ]
]

{ #category : #accessing }
DSShareSettings class >> wasCodeSnippetSelected: aBoolean [ 
	wasCodeSnippetSelected := aBoolean
]

{ #category : #accessing }
DSShareSettings class >> wasPackagesSelected [
	^ wasPackagesSelected ifNil: [ wasPackagesSelected := false ]
]

{ #category : #accessing }
DSShareSettings class >> wasPackagesSelected: aBoolean [ 
	wasPackagesSelected := aBoolean
]

{ #category : #accessing }
DSShareSettings class >> wasScreenshotsSelected [
	^ wasScreenshotsSelected ifNil: [ wasScreenshotsSelected := true ]
]

{ #category : #accessing }
DSShareSettings class >> wasScreenshotsSelected: aBoolean [ 
	wasScreenshotsSelected := aBoolean
]
