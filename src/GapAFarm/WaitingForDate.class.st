Class {
	#name : #WaitingForDate,
	#superclass : #HarvestState,
	#category : #'GapAFarm-telegram'
}

{ #category : #'as yet unclassified' }
WaitingForDate >> handleTextMessage: aMessage for: aChat [

	| dateInput next |
	dateInput := aMessage text.
	(self dateFormatValidation: dateInput) ifFalse: [
		^ GAFBot singleton
			sendChatMessage: 'La fecha ingresada no tiene un formato correcto.'
			to: aChat ].
	next := self nextState.
	self date: dateInput.
	next event: harvestEvent.
	aChat state: next.
	next startFrom: aMessage for: aChat
]

{ #category : #accessing }
WaitingForDate >> nextState [

	harvestEvent date ifNil: [ ^ WaitingForHour new ].
	^ WaitingConfirmationState new
]

{ #category : #'as yet unclassified' }
WaitingForDate >> startFrom: aMessage for: aChat [

	GAFBot singleton
		sendChatMessage:
		'¿Qué día realizó la cosecha? Ingrese la fecha en formato día/mes/año.'
		to: aChat
]
