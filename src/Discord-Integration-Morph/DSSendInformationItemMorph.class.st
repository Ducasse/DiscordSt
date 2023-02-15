Class {
	#name : #DSSendInformationItemMorph,
	#superclass : #DSSendItemMorph,
	#category : 'Discord-Integration-Morph'
}

{ #category : #examples }
DSSendInformationItemMorph class >> withPharoAndOsVersion [
	<gtExample>
	<label: 'With two information values'>
	^ self basic 
		item: DSSendInformationItem withPharoAndOsVersion;
		yourself
]

{ #category : #examples }
DSSendInformationItemMorph class >> withPharoAndOsVersionInWindow [
	<example>
	^ self withPharoAndOsVersion openInWindow
]

{ #category : #'instance creation' }
DSSendInformationItemMorph >> newSendItem [
	^ DSSendInformationItem new
]
