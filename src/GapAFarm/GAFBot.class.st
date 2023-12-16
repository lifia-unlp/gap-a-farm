Class {
	#name : #GAFBot,
	#superclass : #PollingTelegramBot,
	#instVars : [
		'farmsForChats'
	],
	#classInstVars : [
		'singleton'
	],
	#category : #'GapAFarm-telegram'
}

{ #category : #singleton }
GAFBot class >> singleton [

	^ singleton ifNil: [ singleton := self new ]
]

{ #category : #pushing }
GAFBot >> broadcast: aString [

	farmsForChats keysDo: [ :chat |
		self sendChatMessage: aString to: chat ]
]

{ #category : #accessing }
GAFBot >> chatForFarm: aFarm [

	^ farmsForChats keyAtValue: aFarm ifAbsent: [ nil ]
]

{ #category : #unsupported }
GAFBot >> farmForMessage: aMessage [

	| farm |
	farm := farmsForChats at: aMessage chat ifAbsent: [
		        (self farmForTelegramUser: aMessage from) ifNotNil: [ :it |
			        farmsForChats at: aMessage chat put: it ] ].
	^ farm
]

{ #category : #private }
GAFBot >> farmForTelegramUser: aTelegramUser [

	^ (self gafUserFor: aTelegramUser)
		  ifNil: [ nil ]
		  ifNotNil: [ :it | it farms first ]
]

{ #category : #private }
GAFBot >> gafUserFor: aTelegramUser [

	^ GapAFarm singleton users
		  detect: [ :each | each telegramId = aTelegramUser id ]
		  ifNone: [ nil ]
]

{ #category : #hooks }
GAFBot >> handleDocumentMessage: aMessage [

	aMessage answer:
		'Perdón, no estoy preparado para responder mensajes con adjuntos.'
	

]

{ #category : #unsupported }
GAFBot >> handlePhotoMessage: aMessage [

		aMessage answer:
		'Perdón, no estoy preparado para responder mensajes de con imágenes.'

]

{ #category : #unsupported }
GAFBot >> handleTextMessage: aMessage [

	| farm |
	farm := farmsForChats at: aMessage chat ifAbsent: [
		        (self farmForTelegramUser: aMessage from) ifNotNil: [ :it |
			        farmsForChats at: aMessage chat put: it ] ].
	farm ifNil: [
		^ self notifyFarmNotSetFor: aMessage from inResponseTo: aMessage ].
	self offerActionsForFarm: farm inResponseTo: aMessage
]

{ #category : #unsupported }
GAFBot >> handleVoiceMessage: aMessage [

	aMessage answer:
		'Perdón, no estoy preparado para responder mensajes de audio.'
]

{ #category : #private }
GAFBot >> hasElephantMemory [

	^ true
]

{ #category : #'initialize-release' }
GAFBot >> initialize [

	super initialize.
	farmsForChats := Dictionary new.

]

{ #category : #private }
GAFBot >> notifyFarmNotSetFor: aTelegramUser inResponseTo: aMessage [

	| messageText |
	messageText := GAFBotMessageTemplateFactory new
		               farmNotSetNotification asMustacheTemplate value: {
			               ('username' -> aTelegramUser username).
			               ('id' -> aTelegramUser id) } asDictionary.
	aMessage answer: messageText
]

{ #category : #commands }
GAFBot >> novedades: aMessage [

	aMessage answer: 'No tenemos novedades para usted ...'
]

{ #category : #hooks }
GAFBot >> offerActionsForFarm: farm inResponseTo: aMessage [

	aMessage answer:
		(GAFBotMessageTemplateFactory new availableCommands
			 asMustacheTemplate value: {  })
]
