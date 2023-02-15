Class {
	#name : #DSSendScreenshotsAttachment,
	#superclass : #DSSendAttachment,
	#instVars : [
		'screenshots'
	],
	#category : 'Discord-Send-Items'
}

{ #category : #examples }
DSSendScreenshotsAttachment class >> randomMorph [
	<gtExample>
	<label: 'With a random morph'>
	^ self new
		addMorph: World submorphs atRandom;
		yourself.
]

{ #category : #examples }
DSSendScreenshotsAttachment class >> twoRandomMorphs [
	<gtExample>
	<label: 'With a random morph'>
	^ self new
		addMorph: World submorphs atRandom;
		addMorph: World submorphs atRandom;
		yourself.
]

{ #category : #visitor }
DSSendScreenshotsAttachment >> accept: aVisitor [
	^ aVisitor visitDSSendScreenshotsAttachment: self
]

{ #category : #adding }
DSSendScreenshotsAttachment >> add: aDSScreenshot [
	aDSScreenshot isEnabled: self isSelectedAndEnabled.
	self screenshots add: aDSScreenshot.
	self announcer announce: (DSContentChangedAnnouncement new 
		object: self; 
		state: aDSScreenshot; 
		yourself).
	^ aDSScreenshot
]

{ #category : #adding }
DSSendScreenshotsAttachment >> addMorph: aMorph [
	^ self add: (DSMorphScreenshot new morph: aMorph; yourself)
]

{ #category : #private }
DSSendScreenshotsAttachment >> basicChildren [
	^ self screenshots
]

{ #category : #accessing }
DSSendScreenshotsAttachment >> children [
	^ self screenshots
]

{ #category : #'accessing - computed' }
DSSendScreenshotsAttachment >> form [
	"Return all selected screenshots as one Form object"
	<return: #Form>
	| forms form point |
	forms := self screenshots 
		select: [ :eachScreenshot | eachScreenshot isSelected ]
		thenCollect: #form.
	form := Form extent: (forms sum: #extent) depth: (forms max: #depth).
	point := 0 @ 0.
	forms do: [ :eachForm | 
		form := form mergeWith: eachForm at: point.
		point := point + (0 @ eachForm height) ].
	^ form
]

{ #category : #'gt-inspector-extension' }
DSSendScreenshotsAttachment >> gtInspectorCollectionIn: composite [
	<gtInspectorPresentationOrder: 2>
	^ composite fastList
		title: [ 'List' translated ];
		display: [ self screenshots ];
		when: [ self screenshots notEmpty ];
		yourself
]

{ #category : #testing }
DSSendScreenshotsAttachment >> hasSelectedForms [
	^ self screenshots anySatisfy: #isSelected
]

{ #category : #testing }
DSSendScreenshotsAttachment >> includes: anObject [ 
	^ self screenshots anySatisfy: [ :eachScreenshot | 
				eachScreenshot includes: anObject ]
]

{ #category : #initialization }
DSSendScreenshotsAttachment >> initialize [
	super initialize.
	screenshots := OrderedCollection new: 1.
]

{ #category : #accessing }
DSSendScreenshotsAttachment >> screenshots [
	^ screenshots
]

{ #category : #accessing }
DSSendScreenshotsAttachment >> screenshots: aCollection [
	self updateEnabledOfChildren.
	screenshots := aCollection
]
