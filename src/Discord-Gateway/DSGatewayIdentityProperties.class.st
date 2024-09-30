"
I represent properties of the Identity event. 
See DSGatewayIdentityEvent.

Field	Type	Description
$os	string	your operating system
$browser	string	your library name
$device	string	your library name

"
Class {
	#name : 'DSGatewayIdentityProperties',
	#superclass : 'DSGatewayProperties',
	#instVars : [
		'os',
		'browser',
		'device',
		'referrer',
		'referringDomain'
	],
	#category : 'Discord-Gateway-Model',
	#package : 'Discord-Gateway',
	#tag : 'Model'
}

{ #category : 'accessing' }
DSGatewayIdentityProperties >> browser [
	"Return browser identification"
	<return: #String>
	^ browser ifNil: [ browser := DSConstants userAgent ]
]

{ #category : 'accessing' }
DSGatewayIdentityProperties >> browser: anObject [
	browser := anObject
]

{ #category : 'accessing' }
DSGatewayIdentityProperties >> device [
	"Return device identification"
	<return: #String>
	^ device ifNil: [ device := DSConstants deviceVersion ]
]

{ #category : 'accessing' }
DSGatewayIdentityProperties >> device: anObject [
	device := anObject
]

{ #category : 'accessing' }
DSGatewayIdentityProperties >> os [
	"Return operating system identification"
	<return: #String>
	^ os ifNil: [ os := DSConstants osFamily ]
]

{ #category : 'accessing' }
DSGatewayIdentityProperties >> os: anObject [
	os := anObject
]

{ #category : 'accessing' }
DSGatewayIdentityProperties >> referrer [
	^ referrer ifNil: [ referrer := '' ]
]

{ #category : 'accessing' }
DSGatewayIdentityProperties >> referrer: anObject [
	referrer := anObject
]

{ #category : 'accessing' }
DSGatewayIdentityProperties >> referringDomain [
	^ referringDomain ifNil: [ referringDomain := '' ]
]

{ #category : 'accessing' }
DSGatewayIdentityProperties >> referringDomain: anObject [
	referringDomain := anObject
]
