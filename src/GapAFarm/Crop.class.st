Class {
	#name : #Crop,
	#superclass : #GafObject,
	#instVars : [
		'vulgarName',
		'optimalYieldPerPlant'
	],
	#category : #'GapAFarm-model'
}

{ #category : #testing }
Crop class >> isVoyageRoot [
	^ true
]

{ #category : #'instance creation' }
Crop class >> name: aName yield: aYield [
	^ self new
		vulgarName: aName;
		optimalYieldPerPlant: aYield;
		yourself
]

{ #category : #initialization }
Crop >> initialize [
	super initialize.
	optimalYieldPerPlant := 0
]

{ #category : #accessing }
Crop >> optimalYieldPerPlant [
	^ optimalYieldPerPlant
]

{ #category : #accessing }
Crop >> optimalYieldPerPlant: aMeasurement [
	optimalYieldPerPlant := aMeasurement
]

{ #category : #printing }
Crop >> printOn: aStream [
	^ aStream
		nextPutAll: (self vulgarName).
]

{ #category : #accessing }
Crop >> vulgarName [
	^ vulgarName
]

{ #category : #accessing }
Crop >> vulgarName: anObject [
	vulgarName := anObject
]
