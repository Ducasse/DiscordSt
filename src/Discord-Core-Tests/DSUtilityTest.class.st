"
A DSUtilityTest is a test class for testing the behavior of DSUtility
"
Class {
	#name : 'DSUtilityTest',
	#superclass : 'TestCase',
	#category : 'Discord-Core-Tests-Utility',
	#package : 'Discord-Core-Tests',
	#tag : 'Utility'
}

{ #category : 'tests' }
DSUtilityTest >> testDisplayHTTPProgressDuring [
	| result |
	result := DSUtility 
		displayHTTPProgress: 'Downloading icon' 
		during: [ ZnEasy client
			signalProgress: true;
			url: 'https://raw.githubusercontent.com/JurajKubelka/DiscordSt/master/assets/source/download-icon.png';
			get;
			response ].
	self assert: result isSuccess.
]

{ #category : 'tests' }
DSUtilityTest >> testMaterializeFromByteArray [
	| bytes result |
	bytes := DSUtility serializeToByteArray: self.
	result := DSUtility materializeFromByteArray: bytes.
	self assert: result notNil.
	self assert: result class equals: self class.
]

{ #category : 'tests' }
DSUtilityTest >> testPrintHumanReadableBytes [
	self assert: (DSUtility printHumanReadableBytes: 0) equals: '0 bytes'.
	self assert: (DSUtility printHumanReadableBytes: 1) equals: '1 bytes'.
	self assert: (DSUtility printHumanReadableBytes: 9) equals: '9 bytes'.
	self assert: (DSUtility printHumanReadableBytes: 10) equals: '10 bytes'.
	self assert: (DSUtility printHumanReadableBytes: 999) equals: '999 bytes'.
	self assert: (DSUtility printHumanReadableBytes: 1000) equals: '1000 bytes'.
	self assert: (DSUtility printHumanReadableBytes: 1023) equals: '1023 bytes'.
	self assert: (DSUtility printHumanReadableBytes: 1024) equals: '1 KB'.
	self assert: (DSUtility printHumanReadableBytes: 1024 * 1024 - 1) equals: '1024 KB'.
	self assert: (DSUtility printHumanReadableBytes: 1024 * 1024) equals: '1 MB'.
	self assert: (DSUtility printHumanReadableBytes: 1024 * 1024 * 1024 - 1) equals: '1024 MB'.
	self assert: (DSUtility printHumanReadableBytes: 1024 * 1024 * 1024) equals: '1 GB'.
	self assert: (DSUtility printHumanReadableBytes: 1024 * 1024 * 1024 * 1024 - 1) equals: '1024 GB'.
	self assert: (DSUtility printHumanReadableBytes: 1024 * 1024 * 1024 * 1024) equals: '1 TB'.
	self assert: (DSUtility printHumanReadableBytes: 1024 * 1024 * 1024 * 1024 * 1024 - 1) equals: '1024 TB'.
	self assert: (DSUtility printHumanReadableBytes: 1024 * 1024 * 1024 * 1024 * 1024) equals: '1024 TB'.

]

{ #category : 'tests' }
DSUtilityTest >> testSafeFileName [
	| safeString |
	safeString := DSUtility safeFileName: 'a .(DDDSClient): user.name.secondname@gggmaillll.com (detail) (more info) (and more info)'.
	self assert: safeString notNil.
	self assert: safeString equals: 'a-DDDSClient-us'.
]

{ #category : 'tests' }
DSUtilityTest >> testSafeFileName2 [
	| safeString |
	safeString := DSUtility safeFileName: '   a DSClient: user.name.secondname@gggmaillll.com (detail) (d...etc...   '.
	self assert: safeString notNil.
	self assert: safeString equals: 'a-DSClient-user'.
]

{ #category : 'tests' }
DSUtilityTest >> testSafeFileName3 [
	| safeString |
	safeString := DSUtility
		safeFileName: '   a DSClient: user.name.secondname@gggmaillll.com (detail) (d...etc...   ' asText.
	self assert: safeString notNil.
	self assert: safeString equals: 'a-Text-for-a-DSC'
]

{ #category : 'tests' }
DSUtilityTest >> testSerializeToByteArray [
	| bytes |
	bytes := DSUtility serializeToByteArray: self.
	self assert: bytes notNil.
	self assert: bytes class equals: ByteArray.
]
