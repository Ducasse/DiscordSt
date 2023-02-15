Class {
	#name : #DSSendAttachment,
	#superclass : #Object,
	#traits : 'DSSelectableObjectTrait',
	#classTraits : 'DSSelectableObjectTrait classTrait',
	#instVars : [
		'isSelected',
		'isEnabled',
		'announcer'
	],
	#category : 'Discord-Send-Items'
}

{ #category : #visiting }
DSSendAttachment >> accept: aVisitor [
	^ self subclassResponsibility
]

{ #category : #accessing }
DSSendAttachment >> announcer [
	<return: #Announcer>
	^ announcer
]

{ #category : #'private - accessing' }
DSSendAttachment >> basicIsEnabled [
	"Get isEnabled value"
	<return: #Boolean>
	^ isEnabled
]

{ #category : #'private - accessing' }
DSSendAttachment >> basicIsEnabled: aBoolean [
	"Set isEnabled value"
	isEnabled := aBoolean
]

{ #category : #'private - accessing' }
DSSendAttachment >> basicIsSelected [
	"Get isSelected value"
	<return: #Boolean>
	^ isSelected
]

{ #category : #'private - accessing' }
DSSendAttachment >> basicIsSelected: aBoolean [
	"Set isSelected value"
	isSelected := aBoolean
]

{ #category : #accessing }
DSSendAttachment >> children [
	"Return a collection of children that should be displayed to a user, e.g., 
	objects that are attached."
	^ self subclassResponsibility
]

{ #category : #'gt-extension' }
DSSendAttachment >> gtInspectorTreeIn: composite [
	<gtInspectorPresentationOrder: -1>
	^ composite fastTree
			title: [ 'Tree' translated ];
			display: [ self children ];
			when: [ (self class >> #children) isSubclassResponsibility not and: [ self children isEmptyOrNil not ] ];
			children: [ :item | item children ];
			expandedUntil: 1;
			yourself
]

{ #category : #initialization }
DSSendAttachment >> initialize [
	super initialize.
	announcer := self newAnnouncer.
	isSelected := true.
	isEnabled := true.
]

{ #category : #accessing }
DSSendAttachment >> isEnabled [
	^ isEnabled
]

{ #category : #accessing }
DSSendAttachment >> isEnabled: aBoolean [
	self assert: [ aBoolean or: [ aBoolean not ] ] description: 'It should be a boolean'.
	isEnabled = aBoolean ifTrue: [ ^ self ].
	isEnabled := aBoolean.
	self updateEnabledOfChildren.
	self announcer 
		announce: (DSEnabledChangedAnnouncement new 
			object: self;
			state: aBoolean
			yourself)
]

{ #category : #accessing }
DSSendAttachment >> isSelected [
	^ isSelected
]

{ #category : #accessing }
DSSendAttachment >> isSelected: aBoolean [
	self assert: [ aBoolean or: [ aBoolean not ] ] description: 'It should be a boolean'.
	isSelected = aBoolean ifTrue: [ ^ self ].
	isSelected := aBoolean.
	self updateEnabledOfChildren.
	self announcer 
		announce: (DSSelectionChangedAnnouncement new 
			object: self;
			state: aBoolean; 
			yourself)
]

{ #category : #accessing }
DSSendAttachment >> isSelectedAndEnabled [
	^ self isSelected and: [ self isEnabled ]
]

{ #category : #'instance creation' }
DSSendAttachment >> newAnnouncer [
	^ Announcer new
]

{ #category : #printing }
DSSendAttachment >> printOn: aStream [
	super printOn: aStream.
	self isSelected 
		ifTrue: [ aStream << ' (selected, ' ]
		ifFalse: [ aStream << ' (deselected, ' ].
	self isEnabled 
		ifTrue: [ aStream << 'enabled)' ]
		ifFalse: [ aStream << 'disabled)' ].
]
