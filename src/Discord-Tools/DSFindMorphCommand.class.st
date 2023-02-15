"
I search a given model in any root morph (window).
"
Class {
	#name : #DSFindMorphCommand,
	#superclass : #DSAbstractFindMorphCommand,
	#category : 'Discord-Tools-Commands'
}

{ #category : #execute }
DSFindMorphCommand >> execute [
	World submorphs 
		detect: [ :aMorph | aMorph model == self model ] 
		ifFound: [ :aMorph | self morph: aMorph ]
		ifNone: [ "ignore" ].
]
