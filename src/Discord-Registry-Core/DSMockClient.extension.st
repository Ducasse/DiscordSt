Extension { #name : #DSMockClient }

{ #category : #'*Discord-Registry-Core' }
DSMockClient >> asRegistry [
	^ DSClientRegistry new 
		client: self;
		yourself
]
