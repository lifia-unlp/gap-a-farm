Class {
	#name : #WaitingForQuantity,
	#superclass : #HarvestState,
	#category : #'GapAFarm-telegram'
}

{ #category : #'as yet unclassified' }
WaitingForQuantity >> handleTextMessage: aMessage for: aChat [

	| regex input next |
	regex := '\d*' asRegex.
	input := aMessage text.
	(regex matches: input)
		ifTrue: [
			harvestEvent quantity: aMessage text asInteger.
			next := WaitingForComment new.
			next event: harvestEvent.
			aChat state: next.
			next startFrom: aMessage for: aChat ]
		ifFalse: [
			GAFBot singleton
				sendChatMessage: 'La cantidad debe ser un número.'
				toUser: aMessage from ]
]

{ #category : #'as yet unclassified' }
WaitingForQuantity >> startFrom: aMessage for: aChat [

	GAFBot singleton
		sendChatMessage: 'Ingresá la cantidad cosechada (KG).'
		to: aChat
]
