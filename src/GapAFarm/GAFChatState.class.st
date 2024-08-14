Class {
	#name : #GAFChatState,
	#superclass : #Object,
	#category : #'GapAFarm-telegram'
}

{ #category : #'as yet unclassified' }
GAFChatState >> handleTextMessage: aMessage for: aChat [

	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
GAFChatState >> handleVoiceMessage: aMessage for: aChat [

	| sapi bytes |
	sapi := SpeechToTextApi new.
	sapi isProperlyConfigured ifFalse: [
		^ aMessage answer:
			  'Al parecer, la API de transcripción no está correctamente configurada.' ].

	bytes := (aMessage voice readStreamWith: GAFBot singleton) contents.
	^ sapi transcribeByteArray: bytes
	"aMessage answer: 'Usted dijo: ' , text."
]

{ #category : #'as yet unclassified' }
GAFChatState >> startFrom: aMessage for: aChat [

	self subclassResponsibility 

	
]
