"
I am a Trait.
I represent an object that is post to Discord using Webhook, Bot, or User connection.
I represent an object that include attachments, e.g., images.
"
Trait {
	#name : 'TDSDataPost',
	#traits : 'TDSPost',
	#category : 'Discord-Core-Trait',
	#package : 'Discord-Core',
	#tag : 'Trait'
}

{ #category : 'adding' }
TDSDataPost >> addMimePart: aZnMimePart [
	"Adds an attachment (a ZnMimePart) and returns it"
	
	^ self mimeParts add: aZnMimePart
]

{ #category : 'converting' }
TDSDataPost >> asDataPost [
	"Convert a data post.
	I am a data post. So, I return myself."
	^ self
]

{ #category : 'enumerating' }
TDSDataPost >> fileNames [
	"Return existing file names of FilePart objects."

	^ self mimeParts collect: #fileName as: Array
]

{ #category : 'testing' }
TDSDataPost >> isEmpty [
	^ self content isNil and: [ self hasEmbeds and: [ self mimeParts isEmptyOrNil ] ]
]

{ #category : 'adding' }
TDSDataPost >> mimeParts [
	"Return a collection of attachments (ZnMimePart objects)."
	
	^ self explicitRequirement
]
