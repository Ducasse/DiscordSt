"
I am a Trait.
I represent an object that is post to Discord using Webhook, Bot, or User connection.
I represent an object that does not include any attachment, e.g., images.
"
Trait {
	#name : 'TDSJsonPost',
	#traits : 'TDSPost',
	#category : 'Discord-Core-Trait',
	#package : 'Discord-Core',
	#tag : 'Trait'
}

{ #category : 'converting' }
TDSJsonPost >> asDataPost [
	"Convert JSON post to a data post."

	^ self explicitRequirement
]

{ #category : 'testing' }
TDSJsonPost >> isEmpty [
	^ self content isNil and: [ self embed isNil ]
]
