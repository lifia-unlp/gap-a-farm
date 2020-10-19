Class {
	#name : #SpeciesCounter,
	#superclass : #Object,
	#instVars : [
		'speciesCountDictionary'
	],
	#category : #'GapAFarm-Analysis'
}

{ #category : #counting }
SpeciesCounter >> add: anotherCounter [
	anotherCounter speciesCountDictionary
		keysAndValuesDo: [ :key :value | 
			speciesCountDictionary
				at: key
				put: (speciesCountDictionary at: key ifAbsent: [ 0 ]) + value ]
]

{ #category : #counting }
SpeciesCounter >> count: anObject [
	speciesCountDictionary
		at: anObject species
		put: (speciesCountDictionary at: anObject species ifAbsent: [ 0 ]) + 1
]

{ #category : #initialization }
SpeciesCounter >> initialize [
	speciesCountDictionary := IdentityDictionary new
]

{ #category : #printing }
SpeciesCounter >> printOn: aStream [
	aStream nextPutAll: 'Counts ('.
	speciesCountDictionary
		associationsDo: [ :ass | 
			ass printOn: aStream.
			aStream space ].
	aStream nextPutAll: ')'
]

{ #category : #private }
SpeciesCounter >> speciesCountDictionary [
	^ speciesCountDictionary
]
