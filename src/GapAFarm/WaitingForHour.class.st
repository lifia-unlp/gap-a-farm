Class {
	#name : #WaitingForHour,
	#superclass : #HarvestState,
	#category : #'GapAFarm-telegram'
}

{ #category : #'as yet unclassified' }
WaitingForHour >> handleTextMessage: aMessage for: aChat [

	self hour: aMessage text.
	self nextStateStartFrom: aMessage for: aChat  
]

{ #category : #'as yet unclassified' }
WaitingForHour >> startFrom: aMessage for: aChat [

	nextState := WaitingForQuantity new.
	self startMessageFor: aChat
]

{ #category : #'as yet unclassified' }
WaitingForHour >> startMessageFor: aChat [

	GAFBot singleton
		sendChatMessage:
		'Ingresá el horario en el que cosechaste con formato 24hs. Por ejemplo: 06:00 para la mañana o 18:00 para la tarde.'
		to: aChat
]

{ #category : #'as yet unclassified' }
WaitingForHour >> updateFrom: aMessage for: aChat [

	nextState := WaitingConfirmationState new.
	self startMessageFor: aChat 
]
