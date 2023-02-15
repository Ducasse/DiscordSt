Class {
	#name : #DSSendSelectableItem,
	#superclass : #DSSendItem,
	#traits : 'DSSelectableObjectTrait',
	#classTraits : 'DSSelectableObjectTrait classTrait',
	#instVars : [
		'isSelected',
		'isEnabled'
	],
	#category : 'Discord-Send-Items'
}

{ #category : #testing }
DSSendSelectableItem class >> isAbstract [
	^ self name = #DSSendSelectableItem 
]

{ #category : #accessing }
DSSendSelectableItem >> announcer [
	<return: #Announcer>
	^ super announcer
]

{ #category : #'private - accessing' }
DSSendSelectableItem >> basicIsEnabled [
	"Get isEnabled value"
	<return: #Boolean>
	^ isEnabled
]

{ #category : #'private - accessing' }
DSSendSelectableItem >> basicIsEnabled: aBoolean [
	"Set isEnabled value"
	isEnabled := aBoolean
]

{ #category : #'private - accessing' }
DSSendSelectableItem >> basicIsSelected [
	"Get isSelected value"
	<return: #Boolean>
	^ isSelected
]

{ #category : #'private - accessing' }
DSSendSelectableItem >> basicIsSelected: aBoolean [
	"Set isSelected value"
	isSelected := aBoolean
]

{ #category : #initialization }
DSSendSelectableItem >> initialize [
	super initialize.
	isSelected := true.
	isEnabled := true.
]
