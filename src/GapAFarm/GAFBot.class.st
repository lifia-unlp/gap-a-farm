Class {
	#name : #GAFBot,
	#superclass : #PollingTelegramBot,
	#instVars : [
		'gafUsers'
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

{ #category : #hooks }
GAFBot >> handleDocumentMessage: aMessage [

	aMessage answer:
		'Perdón, no estoy preparado para responder mensajes con adjuntos.'
	

]

{ #category : #hooks }
GAFBot >> handlePhotoMessage: aMessage [

		aMessage answer:
		'Perdón, no estoy preparado para responder mensajes de con imágenes.'

]

{ #category : #hooks }
GAFBot >> handleTextMessage: aMessage [

	self halt
	

]

{ #category : #hooks }
GAFBot >> handleVoiceMessage: aMessage [

	aMessage answer:
		'Perdón, no estoy preparado para responder mensajes de audio.'
]

{ #category : #hooks }
GAFBot >> hasElephantMemory [

	^ true
]

{ #category : #hooks }
GAFBot >> initialize [

	super initialize.
	gafUsers := Dictionary new
]
