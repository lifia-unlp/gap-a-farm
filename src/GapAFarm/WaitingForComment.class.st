Class {
	#name : #WaitingForComment,
	#superclass : #HarvestState,
	#category : #'GapAFarm-telegram'
}

{ #category : #'as yet unclassified' }
WaitingForComment >> handleTextMessage: aMessage for: aChat [

	| next |
	harvestEvent comment: aMessage text.
	next := WaitingConfirmationState new.
	next event: harvestEvent.
	aChat state: next.
	next startFrom: aMessage for: aChat
]

{ #category : #'as yet unclassified' }
WaitingForComment >> startFrom: aMessage for: aChat [

	GAFBot singleton
		sendChatMessage: 'Ingresá una nota para esta cosecha.'
		to: aChat
]
