"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestDiscordCoreTests',
	#superclass : 'PackageManifest',
	#category : 'Discord-Core-Tests-Manifest',
	#package : 'Discord-Core-Tests',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestDiscordCoreTests class >> ruleRBLongMethodsRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#DSModelJsonMappingTest)) #'2017-11-07T19:27:51.963973-03:00') )
]

{ #category : 'code-critics' }
ManifestDiscordCoreTests class >> ruleRBRefersToClassRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'DSCoreTestCase class' #isAbstract #true)) #'2017-05-03T16:00:03.346879-03:00') #(#(#RGMethodDefinition #(#'DSMockServer class' #basicUsage #true)) #'2017-05-10T17:14:48.652899-03:00') #(#(#RGMethodDefinition #(#'DSObjectTest class' #isAbstract #true)) #'2017-06-16T18:29:08.143721+02:00') )
]
