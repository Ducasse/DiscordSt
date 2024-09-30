"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestDiscordClient',
	#superclass : 'PackageManifest',
	#category : 'Discord-Client',
	#package : 'Discord-Client'
}

{ #category : 'code-critics' }
ManifestDiscordClient class >> ruleRBRefersToClassRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'DSClient class' #sendSimpleMessage #true)) #'2017-05-08T14:16:22.723239-03:00') #(#(#RGMethodDefinition #(#'DSAnnouncement class' #isAbstract #true)) #'2017-06-13T15:05:01.815465+02:00') #(#(#RGMethodDefinition #(#'DSClient class' #sendMorphAsScreenshot #true)) #'2017-06-14T15:20:39.769735+02:00') #(#(#RGMethodDefinition #(#'DSClient class' #sendImage #true)) #'2017-06-14T15:20:46.732436+02:00') #(#(#RGMethodDefinition #(#'DSClient class' #sendFormAsScreenshot #true)) #'2017-06-14T15:20:58.676504+02:00') #(#(#RGMethodDefinition #(#'DSClient class' #sendEmbed #true)) #'2017-06-20T20:07:05.138324+02:00') #(#(#RGMethodDefinition #(#'DSClient class' #constructEmbedDescriptionUsingMarkdownBuilder #true)) #'2017-11-24T17:14:52.156238-03:00') )
]
