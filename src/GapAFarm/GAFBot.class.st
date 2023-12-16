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

	aMessage answer: 'Lo siento, ' , aTelegramUser username
		,
		'. No tengo una granja asociada a su usuario de telegram. Solicite al administrador de GAP-a-Farm que le vincule a una granje (para ello provea su identificador unico de Telegram: '
		, aTelegramUser id printString , ')'
]

{ #category : #hooks }
GAFBot >> offerActionsForFarm: farm inResponseTo: aMessage [

	aMessage answer:
		'Las acciones disponibles para "' , farm name , '" son ...'
]
