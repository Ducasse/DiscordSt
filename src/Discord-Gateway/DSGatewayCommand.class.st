Class {
	#name : 'DSGatewayCommand',
	#superclass : 'Object',
	#category : 'Discord-Gateway-Commands',
	#package : 'Discord-Gateway',
	#tag : 'Commands'
}

{ #category : 'execute' }
DSGatewayCommand >> execute [
	^ self subclassResponsibility
]
