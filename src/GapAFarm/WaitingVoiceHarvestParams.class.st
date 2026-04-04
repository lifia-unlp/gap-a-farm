Class {
	#name : #WaitingVoiceHarvestParams,
	#superclass : #HarvestState,
	#category : #'GapAFarm-telegram'
}

{ #category : #'as yet unclassified' }
WaitingVoiceHarvestParams >> handleVoiceMessage: aMessage for: aChat [

	self nextStateStartFrom: aMessage for: aChat
]

{ #category : #'as yet unclassified' }
WaitingVoiceHarvestParams >> nextStateStartFrom: aMessage for: aChat [

	aChat state: nextState.
	nextState startFrom: aMessage for: aChat
]

{ #category : #'as yet unclassified' }
WaitingVoiceHarvestParams >> startFrom: aMessage for: aChat [

	nextState := VoiceHarvestState new.
	aMessage answer:
		'Para poder registrar tu cosecha necesito que me indiques:
	- Lote en el cual querés realizar la cosecha
	- Cultivo (Opcional)
	- Hora en la que realizaste la cosecha'
]
