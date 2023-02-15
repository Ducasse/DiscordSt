Class {
	#name : #DSSendInformationItem,
	#superclass : #DSSendSelectableItem,
	#instVars : [
		'infos'
	],
	#category : 'Discord-Send-Items'
}

{ #category : #'instance creation' }
DSSendInformationItem class >> withPharoAndOsVersion [
	^ self new
		addPharoAndOsVersion;
		yourself.
]

{ #category : #visiting }
DSSendInformationItem >> accept: aVisitor [
	^ aVisitor visitDSSendInformationItem: self
]

{ #category : #adding }
DSSendInformationItem >> add: aDSSendInformation [ 
	"Add new information to the collection"
	^ self infos add: aDSSendInformation
]

{ #category : #adding }
DSSendInformationItem >> addName: nameString value: valueString [
	"Add new information to the collection"
	^ self add: (DSSendInformation new name: nameString; value: valueString; yourself)
]

{ #category : #adding }
DSSendInformationItem >> addPharoAndOsVersion [
	self
		add: DSSendInformation newPharoVersion;
		add: DSSendInformation newOsVersion.
]

{ #category : #accessing }
DSSendInformationItem >> children [
	^ self infos
]

{ #category : #'gt-inspector-extension' }
DSSendInformationItem >> gtInspectorInfosIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite fastList
		title: [ 'Infos' translated ];
		display: [ self infos ];
		when: [ self infos notEmpty ];
		yourself.
]

{ #category : #accessing }
DSSendInformationItem >> infos [
	^ infos
]

{ #category : #accessing }
DSSendInformationItem >> infos: anObject [
	infos := anObject
]

{ #category : #initialization }
DSSendInformationItem >> initialize [
	super initialize.
	infos := OrderedCollection new.
]

{ #category : #testing }
DSSendInformationItem >> isInformationItem [
	^ true
]

{ #category : #accessing }
DSSendInformationItem >> isSelected [
	^ isSelected
]

{ #category : #accessing }
DSSendInformationItem >> isSelected: anObject [
	isSelected := anObject
]
