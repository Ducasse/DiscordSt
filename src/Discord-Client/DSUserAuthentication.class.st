"
I represent standard user authentication process.
I should be used only for real users, not bots.

See DSClient class to connect as a standard user.
"
Class {
	#name : #DSUserAuthentication,
	#superclass : #DSAuthentication,
	#category : 'Discord-Client-REST-Api'
}

{ #category : #visiting }
DSUserAuthentication >> accept: aVisitor [
	^ aVisitor visitDSUserAuthentication: self
]
