Class {
	#name : #InventoryItem,
	#superclass : #GafObject,
	#instVars : [
		'substance',
		'movements'
	],
	#category : #'GapAFarm-model'
}

{ #category : #testing }
InventoryItem class >> isVoyageRoot [
	^ true
]

{ #category : #adding }
InventoryItem >> addMovement: aMovement [
	movements add: aMovement
]

{ #category : #utility }
InventoryItem >> balance [
	^ movements sumNumbers: [ :each | each quantity ]
]

{ #category : #initialization }
InventoryItem >> initialize [ 
	super initialize.
	movements:= OrderedCollection new.
]

{ #category : #accessing }
InventoryItem >> movements [
	^ movements
]

{ #category : #accessing }
InventoryItem >> substance [
	^ substance
]

{ #category : #accessing }
InventoryItem >> substance: anObject [
	substance := anObject
]
