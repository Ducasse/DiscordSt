"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestDiscordUIBloc,
	#superclass : #PackageManifest,
	#category : 'Discord-UI-Brick'
}

{ #category : #'code-critics' }
ManifestDiscordUIBloc class >> ruleRBUtilityMethodsRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#DSMessagesDataSource #onCreateHolder:type: #false)) #'2017-10-31T09:48:27.804882-03:00') #(#(#RGMethodDefinition #(#DSBlocElement #newEditorElementForString: #false)) #'2017-10-31T10:47:24.287434-03:00') )
]
