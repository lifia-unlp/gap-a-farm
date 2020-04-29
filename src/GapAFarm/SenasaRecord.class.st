Class {
	#name : #SenasaRecord,
	#superclass : #Object,
	#instVars : [
		'cropVulgarName',
		'residue',
		'applicabilities',
		'activeIngredientTradeName',
		'source'
	],
	#category : #'GapAFarm-senasa'
}

{ #category : #comparing }
SenasaRecord >> = anotherRecord [
	^ cropVulgarName = anotherRecord cropVulgarName
		& (residue = anotherRecord residue)
		& (activeIngredientTradeName = anotherRecord activeIngredientTradeName)
		& (source = anotherRecord source)
		& (applicabilities = anotherRecord applicabilities)
]

{ #category : #accessing }
SenasaRecord >> activeIngredientTradeName [
	^ activeIngredientTradeName
]

{ #category : #accessing }
SenasaRecord >> activeIngredientTradeName: anObject [
	activeIngredientTradeName := anObject
]

{ #category : #accessing }
SenasaRecord >> applicabilities [
	^ applicabilities
]

{ #category : #accessing }
SenasaRecord >> applicabilities: anObject [
	applicabilities := anObject
]

{ #category : #accessing }
SenasaRecord >> cropVulgarName [
	^ cropVulgarName
]

{ #category : #accessing }
SenasaRecord >> cropVulgarName: anObject [
	cropVulgarName := anObject
]

{ #category : #testing }
SenasaRecord >> hasActiveIngredient [
	^ activeIngredientTradeName notNil
		and: [ activeIngredientTradeName notEmpty ]
]

{ #category : #testing }
SenasaRecord >> hasCrop [
	^ cropVulgarName notNil and: [ cropVulgarName notEmpty ]
]

{ #category : #comparing }
SenasaRecord >> hash [
	^ {residue.
	activeIngredientTradeName.
	source} , applicabilities asArray
		inject: cropVulgarName hash
		into: [ :sum :each | sum bitXor: each hash ]
]

{ #category : #testing }
SenasaRecord >> isComplete [
	^ self hasActiveIngredient
]

{ #category : #testing }
SenasaRecord >> isExempt [
	^ residue isNil
]

{ #category : #printing }
SenasaRecord >> printOn: aStream [
	aStream
		nextPutAll: 'a SenasaRecord(';
		nextPutAll: cropVulgarName;
		nextPutAll: ', ';
		nextPutAll: activeIngredientTradeName;
		nextPutAll: ', ';
		nextPutAll: residue printString;
		nextPutAll: ', ';
		nextPutAll: source;
		nextPutAll: ')'
]

{ #category : #testing }
SenasaRecord >> refersToCropNamed: aCropName [
	"returns true if this record is either specific to the crop, or valid for any crop"

	^ cropVulgarName isEmpty | (cropVulgarName = aCropName)
]

{ #category : #accessing }
SenasaRecord >> residue [
	^ residue
]

{ #category : #accessing }
SenasaRecord >> residue: anObject [
	residue := anObject
]

{ #category : #accessing }
SenasaRecord >> source [
	^ source
]

{ #category : #accessing }
SenasaRecord >> source: anObject [
	source := anObject
]
