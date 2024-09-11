Class {
	#name : #VoiceWaitingConfirmationState,
	#superclass : #WaitingConfirmationState,
	#category : #'GapAFarm-telegram'
}

{ #category : #'as yet unclassified' }
VoiceWaitingConfirmationState >> modifyHarvest: aCallbackQueryUpdate [

	| next bot chat |
	bot := GAFBot singleton
		sendChatMessage:
		'Para modificar cualquier dato, repetí el mensaje sólo con los datos que deseás cambiar.'
		to: aCallbackQueryUpdate from.
	chat := bot chatForTelegramUser: (aCallbackQueryUpdate from).
	next := VoiceUpdateState new.
	next event: harvestEvent.
	chat state: next.
]
