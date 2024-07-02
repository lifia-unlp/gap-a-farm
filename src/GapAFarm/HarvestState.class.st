Class {
	#name : #HarvestState,
	#superclass : #GAFChatState,
	#instVars : [
		'harvestEvent'
	],
	#category : #'GapAFarm-telegram'
}

{ #category : #accessing }
HarvestState >> event: anEvent [

	harvestEvent := anEvent 
]
