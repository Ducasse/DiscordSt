Trait {
	#name : #DSSelectableObjectTrait,
	#category : 'Discord-Tools'
}

{ #category : #accessing }
DSSelectableObjectTrait >> announcer [
	<return: #Announcer>
	^ self explicitRequirement
]

{ #category : #'private - accessing' }
DSSelectableObjectTrait >> basicChildren [
	"Subclasses can define children update actions"
	^ #()
]

{ #category : #'private - accessing' }
DSSelectableObjectTrait >> basicIsEnabled [
	"Get isEnabled value"
	<return: #Boolean>
	^ self explicitRequirement
]

{ #category : #'private - accessing' }
DSSelectableObjectTrait >> basicIsEnabled: aBoolean [
	"Set isEnabled value"
	self explicitRequirement
]

{ #category : #'private - accessing' }
DSSelectableObjectTrait >> basicIsSelected [
	"Get isSelected value"
	<return: #Boolean>
	^ self explicitRequirement
]

{ #category : #'private - accessing' }
DSSelectableObjectTrait >> basicIsSelected: aBoolean [
	"Set isSelected value"
	self explicitRequirement
]

{ #category : #accessing }
DSSelectableObjectTrait >> isEnabled [
	^ self basicIsEnabled
]

{ #category : #accessing }
DSSelectableObjectTrait >> isEnabled: aBoolean [
	self basicIsEnabled = aBoolean ifTrue: [ ^ self ].
	self basicIsEnabled: aBoolean.
	self updateEnabledOfChildren.
	self announcer 
		announce: (DSEnabledChangedAnnouncement new 
			object: self;
			state: aBoolean
			yourself)
]

{ #category : #accessing }
DSSelectableObjectTrait >> isSelected [
	^ self basicIsSelected
]

{ #category : #accessing }
DSSelectableObjectTrait >> isSelected: aBoolean [
	self basicIsSelected = aBoolean ifTrue: [ ^ self ].
	self basicIsSelected: aBoolean.
	self updateEnabledOfChildren.
	self announcer 
		announce: (DSSelectionChangedAnnouncement new 
			object: self;
			state: aBoolean
			yourself)
]

{ #category : #testing }
DSSelectableObjectTrait >> isSelectedAndEnabled [
	^ self basicIsEnabled and: [ self basicIsSelected ]
]

{ #category : #'announcement registration' }
DSSelectableObjectTrait >> onContentChangedDo: oneArgBlock [
	"Register for content changes. The block receives the announcement."

	^ self announcer when: DSContentChangedAnnouncement do: oneArgBlock
]

{ #category : #'announcement registration' }
DSSelectableObjectTrait >> onEnabledChangedDo: oneArgBlock [
	"Register for isEnabled changes. The block receives the announcement."

	^ self announcer when: DSEnabledChangedAnnouncement do: oneArgBlock
]

{ #category : #'announcement registration' }
DSSelectableObjectTrait >> onSelectionChangedDo: oneArgBlock [
	"Register for isSelected changes. The block receives the announcement."

	^ self announcer when: DSSelectionChangedAnnouncement do: oneArgBlock
]

{ #category : #'private - children' }
DSSelectableObjectTrait >> updateEnabledOfChildren [
	"Update isEnabled of all direct children."
	self basicChildren do: [ :each | each isEnabled: self isSelectedAndEnabled ]
]
