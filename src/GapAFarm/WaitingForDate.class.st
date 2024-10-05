Class {
	#name : #WaitingForDate,
	#superclass : #HarvestState,
	#category : #'GapAFarm-telegram'
}

{ #category : #'as yet unclassified' }
WaitingForDate >> handleTextMessage: aMessage for: aChat [

	self setDate: aMessage text.
	self nextStateStartFrom: aMessage for: aChat
]

{ #category : #accessing }
WaitingForDate >> nextState [

	harvestEvent date ifNil: [ ^ WaitingForHour new ].
	^ WaitingConfirmationState new
]

{ #category : #'as yet unclassified' }
WaitingForDate >> startFrom: aMessage for: aChat [

	nextState := WaitingForHour new.
	self startMessagefor: aChat
]

{ #category : #'as yet unclassified' }
WaitingForDate >> startMessagefor: aChat [

	GAFBot singleton
		sendChatMessage:
		'¿Qué día realizó la cosecha? Ingrese la fecha en formato día/mes/año.'
		to: aChat
]
