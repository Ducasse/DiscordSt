"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestDiscordGatewayTests',
	#superclass : 'PackageManifest',
	#category : 'Discord-Gateway-Tests-Manifest',
	#package : 'Discord-Gateway-Tests',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestDiscordGatewayTests class >> ruleRBRefersToClassRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'DSGatewayTestCase class' #isAbstract #true)) #'2017-05-09T12:43:49.580849-03:00') #(#(#RGMethodDefinition #(#'DSGatewayApiTest class' #isAbstract #true)) #'2017-05-09T12:43:54.711514-03:00') #(#(#RGMethodDefinition #(#'DSGatewayObjectTest class' #isAbstract #true)) #'2017-06-08T16:17:21.175179+02:00') #(#(#RGMethodDefinition #(#'DSGatewayProcessTest class' #isAbstract #true)) #'2017-06-09T11:53:20.099739+02:00') )
]
