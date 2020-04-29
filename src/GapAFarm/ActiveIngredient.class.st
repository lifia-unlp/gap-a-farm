Class {
	#name : #ActiveIngredient,
	#superclass : #GafObject,
	#instVars : [
		'tradeName',
		'referenceUrl'
	],
	#category : #'GapAFarm-model'
}

{ #category : #testing }
ActiveIngredient class >> isVoyageRoot [
	^ true
]

{ #category : #'instance creation' }
ActiveIngredient class >> tradeName: aName [
	^ self new
		tradeName: aName;
		yourself
]

{ #category : #printing }
ActiveIngredient >> exportToJson [ 
	^ '{ "tradeName" : "' ,  tradeName ,  '" }'
]

{ #category : #printing }
ActiveIngredient >> printOn: aStream [
	^ aStream
		nextPutAll: (self tradeName).
]

{ #category : #accessing }
ActiveIngredient >> referenceUrl [
	^ referenceUrl
]

{ #category : #accessing }
ActiveIngredient >> referenceUrl: anObject [
	referenceUrl := anObject
]

{ #category : #accessing }
ActiveIngredient >> tradeName [
	^ tradeName
]

{ #category : #accessing }
ActiveIngredient >> tradeName: anObject [
	tradeName := anObject
]
