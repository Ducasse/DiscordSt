Class {
	#name : 'DSGatewayUnclassifiedPayload',
	#superclass : 'DSGatewayPayload',
	#instVars : [
		'code'
	],
	#category : 'Discord-Gateway-Model',
	#package : 'Discord-Gateway',
	#tag : 'Model'
}

{ #category : 'accessing' }
DSGatewayUnclassifiedPayload class >> code [
	^ Float infinity
]

{ #category : 'visiting' }
DSGatewayUnclassifiedPayload >> accept: aVisitor [
	^ aVisitor visitDSGatewayUnclassifiedPayload: self
]

{ #category : 'accessing' }
DSGatewayUnclassifiedPayload >> code [
	^ code
]

{ #category : 'accessing' }
DSGatewayUnclassifiedPayload >> code: anObject [
	code := anObject
]
