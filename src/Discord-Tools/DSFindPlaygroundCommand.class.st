"
I search a given model in open GT-Playgrounds.
I search the given model in inner GT-Inspectors too.

"
Class {
	#name : #DSFindPlaygroundCommand,
	#superclass : #DSAbstractFindMorphCommand,
	#category : 'Discord-Tools-Commands'
}

{ #category : #execute }
DSFindPlaygroundCommand >> execute [
	World submorphs
		detect: [ :e | 
			e model class = GTPlayground
				and: [ (e model = self model) or: [ 
					(e model presentations flatCollect: [ :eachInspector | 
							eachInspector panes flatCollect: #presentations ])
								anySatisfy: [ :presentation | presentation entity = self model ] ] ] ]
		ifFound: [ :aMorph | self morph: aMorph ]
		ifNone: [ "ignore" ]
]
