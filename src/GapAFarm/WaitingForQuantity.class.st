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

{ #category : #accessing }
WaitingForQuantity >> nextState [

	harvestEvent quantity ifNil: [ ^ WaitingForComment new ].
	^ WaitingConfirmationState new
]

{ #category : #'as yet unclassified' }
WaitingForQuantity >> startFrom: aMessage for: aChat [

	nextState := WaitingForComment new.
	self startMessagefor: aChat
]

{ #category : #'as yet unclassified' }
WaitingForQuantity >> startMessagefor: aChat [

	GAFBot singleton
		sendChatMessage: 'Ingresá la cantidad cosechada (KG).'
		to: aChat
]
