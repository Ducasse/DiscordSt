Extension { #name : 'DSEmbed' }

{ #category : '*Discord-Core-GT' }
DSEmbed >> gtChildren [
	^ { self image. self thumbnail. self footer } reject: [ :each | each isNil ]  
]

{ #category : '*Discord-Core-GT' }
DSEmbed >> gtInspectorImage: composite [
	<gtInspectorPresentationOrder: 2>
	^ composite morph
		title: [ 'Image' translated ];
		display: [ self image ifNotNil: #asForm ];
		when: [ self hasImage and: [ self image hasKnownScheme ] ];
		yourself
]
