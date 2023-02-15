Class {
	#name : #DSGatewayCommand,
	#superclass : #Object,
	#category : 'Discord-Gateway-Commands'
}

{ #category : #execute }
DSGatewayCommand >> execute [
	^ self subclassResponsibility
]
