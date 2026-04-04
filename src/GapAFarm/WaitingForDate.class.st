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

{ #category : #'as yet unclassified' }
WaitingForDate >> startFrom: aMessage for: aChat [

	nextState := WaitingForHour new.
	self startMessageFor: aChat
]

{ #category : #'as yet unclassified' }
WaitingForDate >> startMessageFor: aChat [

	GAFBot singleton
		sendChatMessage:
		'¿Qué día realizó la cosecha? Ingrese la fecha en formato día/mes/año.'
		to: aChat
]

{ #category : #'as yet unclassified' }
WaitingForDate >> updateFrom: aMessage for: aChat [

	nextState := WaitingConfirmationState new.
	self startMessageFor: aChat 
]
