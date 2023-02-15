"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestDiscordClientTests,
	#superclass : #PackageManifest,
	#category : 'Discord-Client-Tests'
}

{ #category : #'code-critics' }
ManifestDiscordClientTests class >> ruleRBRefersToClassRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'DSClientTestCase class' #isAbstract #true)) #'2017-05-03T10:39:09.938681-03:00') #(#(#RGMethodDefinition #(#'DSClientPostTest class' #isAbstract #true)) #'2017-05-08T10:58:45.80075-03:00') )
]
