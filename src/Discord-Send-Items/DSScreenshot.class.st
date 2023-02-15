Class {
	#name : #DSScreenshot,
	#superclass : #DSSendAttachment,
	#category : 'Discord-Send-Items'
}

{ #category : #accessing }
DSScreenshot >> children [
	"Do not display any child in a graphical widget"
	^ #()
]

{ #category : #accessing }
DSScreenshot >> form [
	"Return a screenshot Form representation"
	<return: #Form>
	^ self subclassResponsibility
]

{ #category : #testing }
DSScreenshot >> includes: anObject [ 
	"Return true if it is a screenshot of a given object"
	^ self subclassResponsibility
]

{ #category : #accessing }
DSScreenshot >> name [
	"Return a screenshot string representation, e.g., window name"
	<return: #String>
	^ self subclassResponsibility
]
