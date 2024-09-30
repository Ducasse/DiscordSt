"
I am a Trait.
I provide an API to build Discord objects to send them to the Discord server.
I provide an unified API that is used by Webhooks, Bots, and User Clients.
"
Trait {
	#name : 'TDSPostBuilder',
	#category : 'Discord-Core-Trait',
	#package : 'Discord-Core',
	#tag : 'Trait'
}

{ #category : 'protocol - attachment' }
TDSPostBuilder >> attachForm: aForm [
	"Add aFrom as a PNG image attachment."
	self 
		fileName: self generatePngFileName 
		form: aForm
]

{ #category : 'protocol - attachment' }
TDSPostBuilder >> attachGifBytes: bytes [
	"Add the bytes as a GIF image attachment."
	self 
		fileName: self generateGifFileName 
		gifBytes: bytes
]

{ #category : 'protocol - basic' }
TDSPostBuilder >> content: aString [
	"Set the message contents (up to 2000 characters)."
	self post content: aString
]

{ #category : 'private' }
TDSPostBuilder >> dataPost [
	"Return a data post object."
	self post: self post asDataPost.
	^ self post
]

{ #category : 'protocol - embed' }
TDSPostBuilder >> embed [
	"Return an embed object"
	<return: #DSEmbed>
	^ self explicitRequirement
]

{ #category : 'protocol - embed' }
TDSPostBuilder >> embedColor: aColor [ 
	"Set embed color."
	self embed color: aColor
]

{ #category : 'protocol - embed' }
TDSPostBuilder >> embedDescription: aString [ 
	"Set embed description. Markdown can be used."
	self embed description: aString
]

{ #category : 'protocol - markdown' }
TDSPostBuilder >> embedDescriptionMarkdown: oneArgBlock [
	"Build Embed Description using a dedicated Markdown builder.
	Receives a block with one argument. 
	The first argument is a Markdown builder."
	self embedDescription: (oneArgBlock cull: self markdown) asString.
]

{ #category : 'protocol - embed' }
TDSPostBuilder >> embedFieldName: nameString value: valueString [
	"Set embed field name and value"
	self embed fieldName: nameString value: valueString
]

{ #category : 'protocol - markdown' }
TDSPostBuilder >> embedFieldName: nameString valueMarkdown: oneArgBlock [
	"Build Embed Field value using a dedicated Markdown builder.
	Receives a block with one argument that receives the Markdown builder"
	self embedFieldName: nameString value: (oneArgBlock cull: self markdown) asString.
]

{ #category : 'protocol - embed' }
TDSPostBuilder >> embedFooterIconForm: aForm [
	"Set embed footer icon"
	"Set a Form object as an image.
	It adds an attachment and an embed footer icon."
	| fileName |
	self dataPost.
	fileName := self generatePngFileName.
	self fileName: fileName form: aForm.
	self embedFooterIconUrl: 'attachment://', fileName.
]

{ #category : 'protocol - embed' }
TDSPostBuilder >> embedFooterIconMorph: aMorph [
	"Set embed footer icon"
	self embedFooterIconForm: aMorph imageForm.
]

{ #category : 'protocol - embed' }
TDSPostBuilder >> embedFooterIconUrl: aString [ 
	"Set embed footer icon URL"
	self embed footerIconUrl: aString
]

{ #category : 'protocol - embed' }
TDSPostBuilder >> embedFooterText: aString [ 
	"Set embed footer text. It can be in Markdown format."
	self embed footerText: aString
]

{ #category : 'protocol - embed' }
TDSPostBuilder >> embedImageForm: aForm [
	"Set a Form object as an image.
	It adds an attachment and an embed image."
	| fileName |
	self dataPost.
	fileName := self generatePngFileName.
	self fileName: fileName form: aForm.
	self embedImageUrl: 'attachment://', fileName.
]

{ #category : 'protocol - embed' }
TDSPostBuilder >> embedImageGIfBytes: bytes [
	"Adds bytes as an attachment and an embed image."
	| fileName |
	self dataPost.
	fileName := self generateGifFileName.
	self fileName: fileName gifBytes: bytes.
	self embedImageUrl: 'attachment://', fileName.
]

{ #category : 'protocol - embed' }
TDSPostBuilder >> embedImageHeight: integer [ 
	"Set embed image height"
	self embed imageHeight: integer
]

{ #category : 'protocol - embed' }
TDSPostBuilder >> embedImageMorph: aMorph [
	"Set a Morph object as an embed image."
	self embedImageForm: aMorph imageForm
]

{ #category : 'protocol - embed' }
TDSPostBuilder >> embedImageUrl: integer [ 
	"Set embed image URL"
	self embed imageUrl: integer
]

{ #category : 'protocol - embed' }
TDSPostBuilder >> embedImageWidth: integer [ 
	"Set embed image width"
	self embed imageWidth: integer
]

{ #category : 'protocol - embed' }
TDSPostBuilder >> embedInlineFieldName: nameString value: valueString [
	"Set inlined embed field name and value"
	self embed inlineFieldName: nameString value: valueString
]

{ #category : 'protocol - markdown' }
TDSPostBuilder >> embedInlineFieldName: nameString valueMarkdown: oneArgBlock [
	"Build inlined Embed Field value using a dedicated Markdown builder.
	Receives a block with one argument that receives the Markdown builder"
	self embedInlineFieldName: nameString value: (oneArgBlock cull: self markdown) asString.
]

{ #category : 'protocol - embed' }
TDSPostBuilder >> embedProviderName: aString [ 
	"Set embed provider name."
	self embed providerName: aString
]

{ #category : 'protocol - embed' }
TDSPostBuilder >> embedProviderUrl: aString [ 
	"Set embed provider URL."
	self embed providerUrl: aString
]

{ #category : 'protocol - embed' }
TDSPostBuilder >> embedThumbnailForm: aForm [
	"Set embed thumbnail icon"
	"Set a Form object as a thumbnail icon.
	It adds an attachment and an embed thumbnail icon."
	| fileName |
	self dataPost.
	fileName := self generatePngFileName.
	self fileName: fileName form: aForm.
	self embedThumbnailUrl: 'attachment://', fileName.
]

{ #category : 'protocol - embed' }
TDSPostBuilder >> embedThumbnailHeight: integer [ 
	"Set embed thumbnail height"
	self embed thumbnailHeight: integer
]

{ #category : 'protocol - embed' }
TDSPostBuilder >> embedThumbnailMorph: aMorph [
	"Set embed footer icon"
	self embedThumbnailForm: aMorph imageForm.
]

{ #category : 'protocol - embed' }
TDSPostBuilder >> embedThumbnailUrl: integer [ 
	"Set embed thumbnail URL"
	self embed thumbnailUrl: integer
]

{ #category : 'protocol - embed' }
TDSPostBuilder >> embedThumbnailWidth: integer [ 
	"Set embed thumbnail width"
	self embed thumbnailWidth: integer
]

{ #category : 'protocol - embed' }
TDSPostBuilder >> embedTitle: aString [ 
	"Set embed title."
	self embed title: aString
]

{ #category : 'protocol - embed' }
TDSPostBuilder >> embedUrl: aString [ 
	"Set embed URL. 
	The URL is opened by clicking on Embed Title or Image."
	self embed url: aString
]

{ #category : 'protocol - embed' }
TDSPostBuilder >> embedVideoHeight: integer [ 
	"Set embed video height"
	self embed videoHeight: integer
]

{ #category : 'protocol - embed' }
TDSPostBuilder >> embedVideoUrl: aString [ 
	"Set embed video URL."
	self embed videoUrl: aString
]

{ #category : 'protocol - embed' }
TDSPostBuilder >> embedVideoWidth: integer [ 
	"Set embed video width"
	self embed videoWidth: integer
]

{ #category : 'protocol - embed' }
TDSPostBuilder >> embeds [
	"Return a collection of embed objects"
	<return: #Array of: #DSEmbed>
	^ self explicitRequirement
]

{ #category : 'protocol - attachment' }
TDSPostBuilder >> fileName: aString bytes: aByteArray [ 
	"Add a byte array as an attachment."
	self 
		fileName: aString 
		entity: (ZnEntity bytes: aByteArray)
]

{ #category : 'protocol - attachment' }
TDSPostBuilder >> fileName: aString entity: aZnEntity [ 
	"Add a byte array as an attachment."
	self dataPost addMimePart: (ZnMimePart 
			fieldName: aString
			fileName: aString 
			entity: aZnEntity)
]

{ #category : 'protocol - attachment' }
TDSPostBuilder >> fileName: aString fileReference: aFileReference [ 
	"Add a file contents as an attachment."
	| mimeType size fileStream entity mimePart |
	mimeType := ZnMimeType forFilenameExtension: (ZnFileSystemUtils extensionFor: aFileReference).
	fileStream := ZnFileSystemUtils oldFileStreamFor: aFileReference.
	"mimeType isBinary ifTrue: [ fileStream binary ]."
	size := ZnFileSystemUtils fileSizeFor: aFileReference.
	(entity := ZnStreamingEntity type: mimeType length: size)
		stream: fileStream.
	mimePart := ZnMimePart fieldName: aString fileName: aString entity: entity.
	self dataPost addMimePart: mimePart.
]

{ #category : 'protocol - attachment' }
TDSPostBuilder >> fileName: aString form: aForm [ 
	"Add a form as a PNG image (screenshot) attachment."
	| encoded |
	encoded := ByteArray new writeStream.
	PNGReadWriter putForm: aForm onStream: encoded.
	self 
		fileName: aString 
		entity: ((ZnEntity bytes: encoded contents) 
				contentType: ZnMimeType imagePng;
				yourself).
]

{ #category : 'protocol - attachment' }
TDSPostBuilder >> fileName: aString fuelObject: anObject [ 
	"Add a serialized object, using FUEL serialization library"
	self 
		fileName: aString
		bytes: (DSUtility serializeToByteArray: anObject)
]

{ #category : 'protocol - attachment' }
TDSPostBuilder >> fileName: fileNameString gifBytes: bytes [
	"Add the bytes as a GIF image attachment."
	self 
		fileName: fileNameString
		entity: ((ZnEntity bytes: bytes) 
				contentType: ZnMimeType imageGif;
				yourself).
]

{ #category : 'protocol - attachment' }
TDSPostBuilder >> fileName: aString  morph: aMorph [ 
	"Add a Morph as a PNG image (screenshot) attachment."
	self fileName: aString form: aMorph imageForm.
]

{ #category : 'protocol - attachment' }
TDSPostBuilder >> fileName: fileNameString string: aString [ 
	"Add a string as an attachment with charset UTF-8."
	self 
		fileName: fileNameString 
		entity: (ZnEntity text: aString)
]

{ #category : 'protocol - attachment' }
TDSPostBuilder >> fileReference: aFileReference [ 
	"Add a file contents as an attachment."
	| baseName |
	baseName := ZnFileSystemUtils baseNameFor: aFileReference.
	self fileName: baseName fileReference: aFileReference
]

{ #category : 'private' }
TDSPostBuilder >> generateFileNameWithExtension: extensionString [
	"Return a unique file name with an extension, e.g., '.png'."
	
	^ DSGenerateFileNameCommand new
		extension: extensionString;
		existingFileNames: self dataPost fileNames;
		execute;
		fileName.
]

{ #category : 'private' }
TDSPostBuilder >> generateGifFileName [
	"Return a unique file name with GIF extension."

	^ self generateFileNameWithExtension: '.gif'
]

{ #category : 'private' }
TDSPostBuilder >> generatePngFileName [
	"Return a unique file name with PNG extention."
	
	^ self generateFileNameWithExtension: '.png'
]

{ #category : 'protocol - testing' }
TDSPostBuilder >> hasEmbedImages [
	"Return true if any embed object has an image."
	^ self embeds anySatisfy: #hasImage
]

{ #category : 'protocol - testing' }
TDSPostBuilder >> hasEmbeds [
	"Return true if a post includes embed objects"
	^ self post hasEmbeds
]

{ #category : 'protocol - testing' }
TDSPostBuilder >> isPostValid [
	"Return true if the existing post is not empty,
	and thus can be sent."
	^ self post isEmpty not
]

{ #category : 'protocol - markdown' }
TDSPostBuilder >> markdown [ 
	"Return a new Markdown builder"
	^ DSMarkdownBuilder new
]

{ #category : 'protocol - markdown' }
TDSPostBuilder >> markdown: twoArgBlock [ 
	"Build a Markdown string using a dedicated Markdown builder.
	Receives a block with two arguments. 
	The first argument is a Markdown builder. 
	The second argument is this object."
	twoArgBlock cull: self markdown cull: self.
]

{ #category : 'protocol - basic' }
TDSPostBuilder >> message: aString [
	"Set the message contents (up to 2000 characters)."
	self content: aString
]

{ #category : 'instance creation' }
TDSPostBuilder >> newEmbed [
	^ DSEmbed new
]

{ #category : 'private' }
TDSPostBuilder >> post [
	"Return a post object."
	^ self explicitRequirement
]

{ #category : 'private' }
TDSPostBuilder >> post: aPost [
	"Set a post object."
	self explicitRequirement
]

{ #category : 'scripting' }
TDSPostBuilder >> with: aBlockClosure [ 
	^ aBlockClosure cull: self
]
