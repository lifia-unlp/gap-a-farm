Class {
	#name : #WaitingForHour,
	#superclass : #HarvestState,
	#category : #'GapAFarm-telegram'
}

{ #category : #'as yet unclassified' }
WaitingForHour >> handleTextMessage: aMessage for: aChat [

	self hour: aMessage text.
	self nextStateStartFrom: aMessage for: aChat  
]

{ #category : #accessing }
WaitingForHour >> nextState [

	harvestEvent time ifNil: [ ^ WaitingForQuantity new ].
	^ WaitingConfirmationState new
]

{ #category : #'as yet unclassified' }
WaitingForHour >> startFrom: aMessage for: aChat [

	nextState := WaitingForQuantity new.
	self startMessagefor: aChat
]

{ #category : #'as yet unclassified' }
WaitingForHour >> startMessagefor: aChat [

	GAFBot singleton
		sendChatMessage: 'Ingresá el horario en el que cosechaste en formato hh:mm.'
		to: aChat
]
