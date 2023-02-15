Class {
	#name : #DSSelection,
	#superclass : #Object,
	#traits : 'DSSelectableObjectTrait',
	#classTraits : 'DSSelectableObjectTrait classTrait',
	#instVars : [
		'item',
		'isSelected',
		'isEnabled',
		'announcer'
	],
	#category : 'Discord-Tools-Support'
}

{ #category : #visiting }
DSSelection >> accept: aVisitor [ 
	^ self subclassResponsibility
]

{ #category : #announcing }
DSSelection >> announceEnabledChanged: aBoolean [
	announcer ifNil: [ ^ self ].
	self announcer announce: (DSEnabledChangedAnnouncement new 
		object: self; 
		state: aBoolean; 
		yourself)
]

{ #category : #announcing }
DSSelection >> announceSelectionChanged: aBoolean [
	announcer ifNil: [ ^ self ].
	self announcer announce: (DSSelectionChangedAnnouncement new 
		object: self; 
		state: aBoolean; 
		yourself)
]

{ #category : #accessing }
DSSelection >> announcer [
	^ announcer ifNil: [ announcer := self newAnnouncer ]
]

{ #category : #'private - accessing' }
DSSelection >> basicIsEnabled [
	"Get isEnabled value"
	<return: #Boolean>
	^ isEnabled
]

{ #category : #'private - accessing' }
DSSelection >> basicIsEnabled: aBoolean [
	"Set isEnabled value"
	isEnabled := aBoolean
]

{ #category : #'private - accessing' }
DSSelection >> basicIsSelected [
	"Get isSelected value"
	<return: #Boolean>
	^ isSelected
]

{ #category : #'private - accessing' }
DSSelection >> basicIsSelected: aBoolean [
	"Set isSelected value"
	isSelected := aBoolean
]

{ #category : #accessing }
DSSelection >> children [
	^ self subclassResponsibility
]

{ #category : #initialization }
DSSelection >> initialize [
	super initialize.
	isSelected := false.
	isEnabled := true.
]

{ #category : #accessing }
DSSelection >> item [
	^ item
]

{ #category : #accessing }
DSSelection >> item: anObject [
	item := anObject
]

{ #category : #accessing }
DSSelection >> itemName [
	^ self item name
]

{ #category : #'instance creation' }
DSSelection >> newAnnouncer [
	^ Announcer new
]

{ #category : #printing }
DSSelection >> printOn: aStream [
	self item ifNil: [ ^ super printOn: aStream ].
	aStream << self item name << ' ('.
	self isSelected 
		ifTrue: [ aStream << 'selected, ' ]
		ifFalse: [ aStream << 'deselected, ' ].
	self isEnabled 
		ifTrue: [ aStream << 'enabled)' ]
		ifFalse: [ aStream << 'disabled)' ].
]
