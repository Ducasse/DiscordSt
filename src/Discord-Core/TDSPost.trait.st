"
I am a Trait.
I represent an object that is post to Discord using Webhook, Bot, or User connection.

"
Trait {
	#name : 'TDSPost',
	#category : 'Discord-Core-Trait',
	#package : 'Discord-Core',
	#tag : 'Trait'
}

{ #category : 'visiting' }
TDSPost >> accept: aVisitor [ 
	^ self explicitRequirement
]

{ #category : 'testing' }
TDSPost >> hasEmbeds [
	"Return true if a post includes embed objects"
	^ self explicitRequirement
]

{ #category : 'visiting' }
TDSPost >> isEmpty [ 
	^ self explicitRequirement
]
