Class {
	#name : #WaitingForPlotState,
	#superclass : #HarvestState,
	#category : #'GapAFarm-telegram'
}

{ #category : #'as yet unclassified' }
WaitingForPlotState >> handleTextMessage: aMessage for: aChat [

	| bot next response |
	
	bot := GAFBot singleton.
	response := self plot: aMessage text for: (bot farmForMessage: aMessage).
	response ifNotNil: [ 	
			self failedInputAttempt > 0
			ifTrue: [
				^ bot sendChatMessage: response
					  to: aChat ]
			ifFalse: [ ^ self tooManyFailedAttemptsFor: aChat ] ].
	self useCurrentCrop.
	next := self nextState.
	aChat state: next.
	next event: harvestEvent.
	next startFrom: aMessage for: aChat
]

{ #category : #accessing }
WaitingForPlotState >> nextState [

	"harvestEvent plot ifNil: [" ^ WaitingForDate new "]."
	"^ WaitingConfirmationState new"
]

{ #category : #'as yet unclassified' }
WaitingForPlotState >> startFrom: aMessage for: aChat [

	| bot |
	bot := GAFBot singleton.
	bot
		sendChatMessage:
		(self plotsToHarvestListforFarm: (bot farmForMessage: aMessage))
		toUser: aMessage from
]
