Class {
	#name : #DSSendItem,
	#superclass : #Object,
	#instVars : [
		'priority',
		'announcer'
	],
	#category : 'Discord-Send-Items'
}

{ #category : #visiting }
DSSendItem >> accept: aVisitor [
	^ self subclassResponsibility
]

{ #category : #accessing }
DSSendItem >> announcer [
	<return: #Announcer>
	^ announcer
]

{ #category : #accessing }
DSSendItem >> children [
	"Return a collection of object that should be displayed to a user"
	^ self subclassResponsibility
]

{ #category : #accessing }
DSSendItem >> defaultPriority [
	"Override it if you want to alter item order"
	^ 0
]

{ #category : #initialization }
DSSendItem >> initialize [
	super initialize.
	priority := self defaultPriority.
	announcer := self newAnnouncer
]

{ #category : #testing }
DSSendItem >> isAttachmentItem [
	^ false
]

{ #category : #testing }
DSSendItem >> isInformationItem [
	^ false
]

{ #category : #testing }
DSSendItem >> isPackagesItem [
	^ false
]

{ #category : #testing }
DSSendItem >> isRegistriesItem [
	^ false
]

{ #category : #testing }
DSSendItem >> isScreenshotItem [
	^ false
]

{ #category : #testing }
DSSendItem >> isUserTextMessageItem [
	^ false
]

{ #category : #'instance creation' }
DSSendItem >> newAnnouncer [
	^ Announcer new
]

{ #category : #accessing }
DSSendItem >> priority [
	^ priority
]

{ #category : #accessing }
DSSendItem >> priority: anObject [
	priority := anObject
]
