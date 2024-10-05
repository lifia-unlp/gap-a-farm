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

	previousState failedInputAttempt > 0
		ifTrue: [
			nextState := previousState.
			GAFBot singleton sendChatMessage: message to: aChat.
			self nextStateStartFrom: aMessage for: aChat ]
		ifFalse: [
			aChat state: nil.
			self tooManyFailedAttemptsFor: aChat ]
]
