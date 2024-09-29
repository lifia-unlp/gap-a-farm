Class {
	#name : #ErrorState,
	#superclass : #HarvestState,
	#instVars : [
		'message',
		'previousState'
	],
	#category : #'GapAFarm-telegram'
}

{ #category : #accessing }
ErrorState >> previousState: aState [

	previousState := aState
	
]

{ #category : #initialization }
ErrorState >> setMessage: aText [

	message := aText
]

{ #category : #'as yet unclassified' }
ErrorState >> startFrom: aMessage for: aChat [

	self failedInputAttempt > 0
		ifTrue: [ GAFBot singleton sendChatMessage: message to: aChat ]
		ifFalse: [ self tooManyFailedAttemptsFor: aChat ].
	nextState := previousState.
	nextState event: harvestEvent.
	nextState startFrom: aMessage for: aChat
	
		
]
