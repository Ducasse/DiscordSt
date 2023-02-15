Class {
	#name : #DSSendPackagesAttachment,
	#superclass : #DSSendAttachment,
	#instVars : [
		'packages'
	],
	#category : 'Discord-Send-Items'
}

{ #category : #examples }
DSSendPackagesAttachment class >> withObjectAndCollectionClasses [
	<gtExample>
	<label: 'Collection with selected Object and Collection class'>
	^ self new 
		packages: DSPackages withObjectAndCollectionClasses;
		yourself
]

{ #category : #visitor }
DSSendPackagesAttachment >> accept: aVisitor [
	^ aVisitor visitDSSendPackagesAttachment: self
]

{ #category : #private }
DSSendPackagesAttachment >> basicChildren [
	^ self packages
]

{ #category : #accessing }
DSSendPackagesAttachment >> children [
	^ self packages
]

{ #category : #initialization }
DSSendPackagesAttachment >> initialize [
	super initialize.
	packages := DSPackages new: 0.
	isSelected := false.
]

{ #category : #accessing }
DSSendPackagesAttachment >> packages [
	^ packages
]

{ #category : #accessing }
DSSendPackagesAttachment >> packages: aCollection [
	aCollection do: [ :each | each isEnabled: self isSelected ].
	packages := aCollection
]
