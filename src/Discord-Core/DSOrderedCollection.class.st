"
I represent an specialized ordered collection used by the Discord library.
"
Class {
	#name : 'DSOrderedCollection',
	#superclass : 'OrderedCollection',
	#category : 'Discord-Core-Collections',
	#package : 'Discord-Core',
	#tag : 'Collections'
}

{ #category : 'accessing' }
DSOrderedCollection class >> jsonMappingClass [
	"Return Model-JSON mapping class, that is able to read and write JSON representations."
	^ DSModelJsonMapping
]
