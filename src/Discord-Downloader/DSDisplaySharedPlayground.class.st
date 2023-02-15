Class {
	#name : #DSDisplaySharedPlayground,
	#superclass : #DSCommand,
	#instVars : [
		'playground',
		'window',
		'sharedData',
		'postExecutions',
		'otherWindows'
	],
	#category : 'Discord-Downloader'
}

{ #category : #accessing }
DSDisplaySharedPlayground >> codeSnippet [
	<return: #String>
	^ self sharedData
		detect: [ :eachData | eachData isCodeSnippet ]
		ifFound: [ :aData | aData string ]
		ifNone: [ '' ]

]

{ #category : #execute }
DSDisplaySharedPlayground >> execute [
	| page |
	page := GTPlayPage new.
	page saveContent: self codeSnippet.
	playground := GTPlayground new.
	playground entity: page.
	self sharedData do: [ :eachData | eachData accept: self ].
	window := playground open.
	postExecutions do: #value.
]

{ #category : #initialization }
DSDisplaySharedPlayground >> initialize [
	super initialize.
	sharedData := #().
	postExecutions := OrderedCollection new: 1.
	otherWindows := OrderedCollection new: 1.
]

{ #category : #accessing }
DSDisplaySharedPlayground >> otherWindows [
	^ otherWindows
]

{ #category : #accessing }
DSDisplaySharedPlayground >> playground [
	<return: #GTPlayground>
	^ playground
]

{ #category : #accessing }
DSDisplaySharedPlayground >> sharedData [
	^ sharedData
]

{ #category : #accessing }
DSDisplaySharedPlayground >> sharedData: anObject [
	sharedData := anObject
]

{ #category : #visiting }
DSDisplaySharedPlayground >> visitDSSharedCodeSnippet: aDSSharedCodeSnippet [ 
	"ignore"
]

{ #category : #visiting }
DSDisplaySharedPlayground >> visitDSSharedTonel: aDSSharedTonel [ 
	self playground monticelloPort 
		value: aDSSharedTonel.
	postExecutions add: [ 
		otherWindows add: (DSOpenTonelArchiveCommand new
			bytes: aDSSharedTonel bytes;
			execute;
			window) ].
]

{ #category : #accessing }
DSDisplaySharedPlayground >> window [
	<return: #SystemWindow>
	^ window
]
