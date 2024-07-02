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
GAFChatState >> startFrom: aMessage for: aChat [

	self subclassResponsibility 

	
]
