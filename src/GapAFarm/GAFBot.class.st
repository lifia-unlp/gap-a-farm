Class {
	#name : #GAFBot,
	#superclass : #PollingTelegramBot,
	#instVars : [
		'farmsForTelegramUsers'
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

{ #category : #private }
GAFBot >> farmFor: aTelegramUser [

	^ farmsForTelegramUsers at: aTelegramUser ifAbsent: [
		  (self gafUserFor: aTelegramUser)
			  ifNil: [ nil ]
			  ifNotNil: [ :it |
			  farmsForTelegramUsers at: aTelegramUser put: it farms first ] ]
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
	farm := self farmFor: aMessage from.
	farm ifNil: [ ^ self notifyFarmNotSetFor: aMessage ].
	
	self offerActionsForFarm: farm inResponseTo: aMessage.
	
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
	farmsForTelegramUsers := Dictionary new
]

{ #category : #private }
GAFBot >> notifyFarmNotSetFor: aMessage [

	aMessage answer: 'Lo siento, ' , aMessage from username
		,
		'. No tengo una granja asociada a su usuario de telegram. Solicite al administrador de GAP-a-Farm que le vincule a una granje (para ello provea su identificador unico de Telegram: '
		, aMessage from id printString, ')'.
]

{ #category : #hooks }
GAFBot >> offerActionsForFarm: farm inResponseTo: aMessage [

	aMessage answer:
		'Las acciones disponibles para "' , farm name , '" son ...'
]
