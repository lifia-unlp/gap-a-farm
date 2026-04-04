Class {
	#name : #WaitingForComment,
	#superclass : #HarvestState,
	#category : #'GapAFarm-telegram'
}

{ #category : #'as yet unclassified' }
WaitingForComment >> handleTextMessage: aMessage for: aChat [

	self comment: aMessage text.
	self nextStateStartFrom: aMessage for: aChat
]

{ #category : #'as yet unclassified' }
WaitingForComment >> startFrom: aMessage for: aChat [

	nextState := WaitingConfirmationState new.
	self startMessageFor: aChat

]

{ #category : #'as yet unclassified' }
WaitingForComment >> startMessageFor: aChat [

	GAFBot singleton
		sendChatMessage: 'Ingresá una nota para esta cosecha.'
		to: aChat
]
