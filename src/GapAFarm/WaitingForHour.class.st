Class {
	#name : #WaitingForHour,
	#superclass : #HarvestState,
	#category : #'GapAFarm-telegram'
}

{ #category : #'as yet unclassified' }
WaitingForHour >> handleTextMessage: aMessage for: aChat [

	| hourInput next |
	hourInput := aMessage text.
	(self hourFormatValidation: hourInput) ifFalse: [
		^ GAFBot singleton
			  sendChatMessage:
			  'El horario que ingresaste es incorrecto. Volvé a intentarlo.'
			  to: aChat ].
	next := self nextState.
	self hour: hourInput.
	next event: harvestEvent.
	aChat state: next.
	next startFrom: aMessage for: aChat
]

{ #category : #accessing }
WaitingForHour >> nextState [

	harvestEvent time ifNil: [ ^ WaitingForQuantity new ].
	^ WaitingConfirmationState new
]

{ #category : #'as yet unclassified' }
WaitingForHour >> startFrom: aMessage for: aChat [

	GAFBot singleton
		sendChatMessage: 'Ingresá el horario en el que cosechaste.'
		to: aChat
]
