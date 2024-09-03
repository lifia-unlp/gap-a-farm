Class {
	#name : #VoiceWaitingConfirmationState,
	#superclass : #WaitingConfirmationState,
	#category : #'GapAFarm-telegram'
}

{ #category : #'as yet unclassified' }
VoiceWaitingConfirmationState >> handleVoiceMessage: aMessage for: aChat [

	| next |
	next := VoiceParseState new.
	next event: harvestEvent.
	aChat state: next.
	next startFrom: aMessage for: aChat
]

{ #category : #'as yet unclassified' }
VoiceWaitingConfirmationState >> modifyHarvest: aCallbackQueryUpdate [

	GAFBot singleton
		sendChatMessage:
		'Para modificar cualquier dato, repetí el mensaje sólo con los datos que deseás cambiar.'
		to: aCallbackQueryUpdate from
]
