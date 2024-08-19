Class {
	#name : #WaitingForQuantity,
	#superclass : #HarvestState,
	#category : #'GapAFarm-telegram'
}

{ #category : #'as yet unclassified' }
WaitingForQuantity >> handleTextMessage: aMessage for: aChat [

	| quantityInput next |
	quantityInput := aMessage text.
	(self quantityFormatValidation: quantityInput) ifFalse: [
		^ GAFBot singleton
			  sendChatMessage: 'La cantidad debe ser un número.'
			  toUser: aMessage from ].
	next := self nextState.
	self quantity: quantityInput.
	next event: harvestEvent.
	aChat state: next.
	next startFrom: aMessage for: aChat
]

{ #category : #accessing }
WaitingForQuantity >> nextState [

	harvestEvent quantity ifNil: [ ^ WaitingForComment new ].
	^ WaitingConfirmationState new
]

{ #category : #'as yet unclassified' }
WaitingForQuantity >> startFrom: aMessage for: aChat [

	GAFBot singleton
		sendChatMessage: 'Ingresá la cantidad cosechada (KG).'
		to: aChat
]
