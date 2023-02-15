Class {
	#name : #DSSendInformation,
	#superclass : #Object,
	#traits : 'DSSelectableObjectTrait',
	#classTraits : 'DSSelectableObjectTrait classTrait',
	#instVars : [
		'isSelected',
		'isEnabled',
		'name',
		'value'
	],
	#category : 'Discord-Send-Items'
}

{ #category : #'instance creation' }
DSSendInformation class >> newOsVersion [
	"Return an object that represents the operating system version."
	^ self new 
		name: 'OS';
		value: (Smalltalk os name asString, ' - ', Smalltalk os version asString);
		yourself
]

{ #category : #'instance creation' }
DSSendInformation class >> newPharoVersion [
	"Return an object that represents the Pharo version."
	^ self new 
		name: 'Pharo';
		value: (SystemVersion current version asString, 
			' - ', SystemVersion current highestUpdate asString, 
			' (', (Smalltalk wordSize = 4 ifTrue: [ '32' ] ifFalse: [ '64' ]), 'bits)');
		yourself
]

{ #category : #'instance creation' }
DSSendInformation class >> newShare [
	"Return an object that represents a sharing information."
	^ self new 
		name: 'Share';
		yourself
]

{ #category : #'private - accessing' }
DSSendInformation >> basicIsEnabled [
	"Get isEnabled value"
	<return: #Boolean>
	^ isEnabled 
]

{ #category : #'private - accessing' }
DSSendInformation >> basicIsEnabled: aBoolean [
	"Set isEnabled value"
	isEnabled := aBoolean
]

{ #category : #'private - accessing' }
DSSendInformation >> basicIsSelected [
	"Get isSelected value"
	<return: #Boolean>
	^ isSelected
]

{ #category : #'private - accessing' }
DSSendInformation >> basicIsSelected: aBoolean [
	"Set isSelected value"
	^ isSelected := aBoolean
]

{ #category : #accessing }
DSSendInformation >> children [
	^ #()
]

{ #category : #initialization }
DSSendInformation >> initialize [
	super initialize.
	name := 'unknown name'.
	value := nil.
	isSelected := true.
	isEnabled := true.
]

{ #category : #accessing }
DSSendInformation >> name [
	^ name
]

{ #category : #accessing }
DSSendInformation >> name: anObject [
	name := anObject
]

{ #category : #printing }
DSSendInformation >> printOn: aStream [
	aStream
		nextPutAll: 'Info: ';
		print: self name;
		nextPutAll: ' value: ';
		print: self value.
]

{ #category : #accessing }
DSSendInformation >> value [
	^ value
]

{ #category : #accessing }
DSSendInformation >> value: anObject [
	value := anObject
]
