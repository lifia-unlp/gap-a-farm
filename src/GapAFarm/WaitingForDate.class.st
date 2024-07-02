Class {
	#name : #WaitingForDate,
	#superclass : #HarvestState,
	#category : #'GapAFarm-telegram'
}

{ #category : #'as yet unclassified' }
WaitingForDate >> handleTextMessage: aMessage for: aChat [

	| regex dateInput dateStrings next |
	regex := '([0-2][1-9]|3[0-1])/(0[1-9]|1[0-2])/\d*' asRegex.
	dateInput := aMessage text.
	(regex matches: dateInput)
		ifTrue: [
			dateStrings := dateInput substrings: '/'.
			harvestEvent date: (Date
					 newDay: dateStrings first asInteger
					 month: dateStrings second asInteger
					 year: dateStrings third asInteger).
			next := WaitingForHour new.
			next event: harvestEvent.
			aChat state: next.
			next startFrom: aMessage for: aChat ]
		ifFalse: [
			GAFBot singleton
				sendChatMessage:
				'La fecha ingresada no tiene un formato correcto.'
				to: aChat ]
]

{ #category : #'as yet unclassified' }
WaitingForDate >> startFrom: aMessage for: aChat [

	GAFBot singleton
		sendChatMessage:
		'¿Qué día realizó la cosecha? Ingrese la fecha en formato día/mes/año.'
		to: aChat
]
