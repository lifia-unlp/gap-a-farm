Class {
	#name : #WaitingForQuantity,
	#superclass : #HarvestState,
	#category : #'GapAFarm-telegram'
}

{ #category : #'as yet unclassified' }
WaitingForQuantity >> handleTextMessage: aMessage for: aChat [

	self quantity: aMessage text.
	self nextStateStartFrom: aMessage for: aChat  
]

{ #category : #'as yet unclassified' }
WaitingForQuantity >> startFrom: aMessage for: aChat [

	nextState := WaitingConfirmationState new. "WaitingForComment new."
	self startMessageFor: aChat
]

{ #category : #'as yet unclassified' }
WaitingForQuantity >> startMessageFor: aChat [

	GAFBot singleton
		sendChatMessage: 'Ingresá un número para indicar la cantidad cosechada (en KG).'
		to: aChat
]

{ #category : #'as yet unclassified' }
WaitingForQuantity >> updateFrom: aMessage for: aChat [

	nextState := WaitingConfirmationState new.
	self startMessageFor: aChat  
]
