Class {
	#name : #Measurement,
	#superclass : #Object,
	#instVars : [
		'magnitude',
		'unit'
	],
	#category : #'GapAFarm-model'
}

{ #category : #voyage }
Measurement class >> isVoyageRoot [
	^ false
]

{ #category : #'instance creation' }
Measurement class >> magnitude: aNumber unit: aString [
	^ self new
		magnitude: aNumber unit: aString;
		yourself
]

{ #category : #accessing }
Measurement >> magnitude [
	^ magnitude
]

{ #category : #accessing }
Measurement >> magnitude: anObject [
	magnitude := anObject
]

{ #category : #initialization }
Measurement >> magnitude: anInteger unit: aString [
	magnitude := anInteger.
	unit := aString
]

{ #category : #printing }
Measurement >> printOn: aStream [
	aStream
		nextPutAll: magnitude printString;
		nextPutAll: ' ';
		nextPutAll: unit
]

{ #category : #accessing }
Measurement >> unit [
	^ unit
]

{ #category : #accessing }
Measurement >> unit: anObject [
	unit := anObject
]
