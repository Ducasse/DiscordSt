"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestDiscordGateway',
	#superclass : 'PackageManifest',
	#category : 'Discord-Gateway-Manifest',
	#package : 'Discord-Gateway',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestDiscordGateway class >> ruleRBBadMessageRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'DSGatewayModelJsonMapping class' #read:withMapping:on: #true)) #'2017-11-09T10:18:26.769953-03:00') #(#(#RGMethodDefinition #(#'DSGatewayModelJsonMapping class' #write:mappedTo: #true)) #'2017-11-09T10:18:30.259247-03:00') )
]

{ #category : 'code-critics' }
ManifestDiscordGateway class >> ruleRBRefersToClassRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'DSGatewayApi class' #isAbstract #true)) #'2017-05-09T12:43:37.729065-03:00') #(#(#RGMethodDefinition #(#'DSGatewayState class' #isAbstract #true)) #'2017-05-10T16:32:33.523201-03:00') )
]

{ #category : 'code-critics' }
ManifestDiscordGateway class >> ruleRBTempsReadBeforeWrittenRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#DSGatewayReadingProcess #doCycle #false)) #'2017-11-10T16:24:34.674252-03:00') )
]
