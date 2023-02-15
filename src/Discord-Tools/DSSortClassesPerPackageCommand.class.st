"
I sort given classes per package and name. 
By calling #packages message, I return DSSelections collection that includes DSPackageSelection instances.
That way the DSSelections collection can be used as an input for a tree UI view to displays classes in a structured way to a user.
"
Class {
	#name : #DSSortClassesPerPackageCommand,
	#superclass : #DSToolCommand,
	#instVars : [
		'classes',
		'packages'
	],
	#category : 'Discord-Tools-Commands'
}

{ #category : #accessing }
DSSortClassesPerPackageCommand >> classes [
	^ classes
]

{ #category : #accessing }
DSSortClassesPerPackageCommand >> classes: anObject [
	classes := anObject
]

{ #category : #execute }
DSSortClassesPerPackageCommand >> execute [
	self packages: DSPackages new.
	self classes do: [ :eachClass | | package |
		package := eachClass package.
		self packages 
			detect: [ :eachPackage | eachPackage item = package ]
			ifFound: [ :aPackage | 
				aPackage addClassSelection: (DSClassSelection new
					item: eachClass;
					isSelected: true;
					yourself) ]
			ifNone: [ | selection | 
				selection := DSPackageSelection new 
					item: package;
					"isSelected: true;"
					addClassSelection: (DSClassSelection new
						item: eachClass;
						isSelected: true;
						yourself);
					yourself.
				self packages addLast: selection ] ].
	packages sort: [ :a :b | a item name < b item name ].
	packages do: [ :eachPackage | 
		eachPackage classes sort: [ :a :b | a item name < b item name ] ].
]

{ #category : #accessing }
DSSortClassesPerPackageCommand >> packages [
	^ packages
]

{ #category : #accessing }
DSSortClassesPerPackageCommand >> packages: anObject [
	packages := anObject
]
