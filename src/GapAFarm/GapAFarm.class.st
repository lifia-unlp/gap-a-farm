Class {
	#name : #GapAFarm,
	#superclass : #Object,
	#classInstVars : [
		'singleton'
	],
	#category : #'GapAFarm-model'
}

{ #category : #singleton }
GapAFarm class >> singleton [
	^ singleton ifNil: [ singleton := self new ]
]

{ #category : #'db queries' }
GapAFarm >> activeIngredients [
	^ ActiveIngredient selectAll
		asSortedCollection: [ :a :b | a tradeName < b tradeName ]
]

{ #category : #'db queries' }
GapAFarm >> applications [
	^ Application selectAll
]

{ #category : #'db queries' }
GapAFarm >> canRemoveSubstance: aSubstance [
	^ (self applications , self inventoryItems
		anySatisfy: [ :each | each substance = aSubstance ]) not
]

{ #category : #'db queries' }
GapAFarm >> cropNamed: aName [
	^ (Crop selectMany: [ :each | each vulgarName = aName ])
		asSortedCollection: [ :a :b | a vulgarName < b vulgarName ]
]

{ #category : #'db queries' }
GapAFarm >> crops [
	^ Crop selectAll
		asSortedCollection: [ :a :b | a vulgarName < b vulgarName ]
]

{ #category : #'db queries' }
GapAFarm >> farmNamed: aName [
	^ Farm selectOne: [ :each | each name = aName ]
]

{ #category : #'db queries' }
GapAFarm >> farms [
	^ Farm selectAll asSortedCollection: [ :a :b | a name < b name ]
]

{ #category : #'db queries' }
GapAFarm >> inventoryItems [
	^ InventoryItem selectAll
]

{ #category : #testing }
GapAFarm >> isSubstanceCommercialNameInUse: aCommercialName byOtherThan: aSubstance [
	| nameMatches |
	nameMatches := self substances
		select: [ :each | each comercialName = aCommercialName ].
	^ nameMatches anySatisfy: [ :each | each ~= aSubstance ]
]

{ #category : #'db queries' }
GapAFarm >> numberOfUsersForSubstance: aSubstance [
	^ self inventoryItems count: [ :each | each substance = aSubstance ]
]

{ #category : #'factory methods' }
GapAFarm >> register: anEmailAddress withHashedPassword: aHashedPassword andName: aFullName [
	| user firstFarm |
	user := GAFUser new
		email: anEmailAddress;
		hashedPassword: aHashedPassword;
		fullname: aFullName;
		yourself.
	firstFarm := Farm name: 'A farm for ' , anEmailAddress.
	firstFarm save.
	user addFarm: firstFarm.
	user save.
	^ user
]

{ #category : #senasa }
GapAFarm >> registeredCropsForActiveIngredient: activeIngrediente [
	"may return the empty string"

	^ (SenasaCatalogue singleton
		registeredCropNamesForActiveIngredientNamed: activeIngrediente tradeName)
		flatCollect: [ :cropName | self cropNamed: cropName ]
]

{ #category : #'db queries' }
GapAFarm >> substanceWithCommercialName: aCommercialName [
	^ Substance selectAll
		detect: [ :each | each comercialName = aCommercialName ]
		ifNone: [ nil ]
]

{ #category : #'db queries' }
GapAFarm >> substances [
	^ Substance selectAll
		asSortedCollection: [ :a :b | a comercialName < b comercialName ]
]

{ #category : #'db queries' }
GapAFarm >> userWithEmail: anEmailAddress [
	^ GAFUser selectOne: [ :each | each email = anEmailAddress ]
]

{ #category : #'db queries' }
GapAFarm >> users [
	^ GAFUser selectAll
]
