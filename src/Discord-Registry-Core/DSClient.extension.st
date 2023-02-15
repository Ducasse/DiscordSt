Extension { #name : #DSClient }

{ #category : #'*Discord-Registry-Core' }
DSClient >> asRegistry [
	^ DSClientRegistry new 
		client: self;
		yourself
]

{ #category : #'*Discord-Registry-Core' }
DSClient classSide >> defaultRegistry [
	<registryOrder: 1>
	^ DSSingletonClientRegistry new
]
