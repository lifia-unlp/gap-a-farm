Class {
	#name : #WaitingForHour,
	#superclass : #HarvestState,
	#category : #'GapAFarm-telegram'
}

{ #category : #'as yet unclassified' }
WaitingForHour >> handleTextMessage: aMessage for: aChat [

	| regex hourInput next |
	regex := '^(0[0-9]|1[0-9]|2[0-3])\:[0-5][0-9]' asRegex.
	hourInput := aMessage text.
	(regex matches: hourInput)
		ifTrue: [
			harvestEvent time: (Time fromString: aMessage text).
			next := WaitingForQuantity new.
			next event: harvestEvent.
			aChat state: next.
			next startFrom: aMessage for: aChat ]
		ifFalse: [
			GAFBot singleton
				sendChatMessage:
				'El horario que ingresaste es incorrecto. Volvé a intentarlo.'
				to: aChat ]
]

{ #category : #'as yet unclassified' }
WaitingForHour >> startFrom: aMessage for: aChat [

	GAFBot singleton
		sendChatMessage: 'Ingresá el horario en el que cosechaste.'
		to: aChat
]
