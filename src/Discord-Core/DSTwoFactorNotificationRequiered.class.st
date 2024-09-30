Class {
	#name : 'DSTwoFactorNotificationRequiered',
	#superclass : 'Error',
	#instVars : [
		'code'
	],
	#category : 'Discord-Core-Exceptions',
	#package : 'Discord-Core',
	#tag : 'Exceptions'
}

{ #category : 'accessing' }
DSTwoFactorNotificationRequiered >> code [
	^ code
]

{ #category : 'accessing' }
DSTwoFactorNotificationRequiered >> code: anObject [
	code := anObject
]

{ #category : 'testing' }
DSTwoFactorNotificationRequiered >> isResumable [
	"Determine whether an exception is resumable."
	^ code isString and: [ code notEmpty ]
]
