"
I am an abstract object for all Discord objects. My subclasses has to know what values should be included in JSON request, see includeInstanceVariables message.
"
Class {
	#name : #DSObject,
	#superclass : #Object,
	#traits : 'TDSObjectTree',
	#classTraits : 'TDSObjectTree classTrait',
	#category : 'Discord-Core-Model'
}

{ #category : #defaults }
DSObject class >> defaultCollection [
	^ #()
]

{ #category : #accessing }
DSObject class >> jsonMappingClass [
	"Return Model-JSON mapping class, that is able to read and write JSON representations."
	^ DSModelJsonMapping
]
