Class {
	#name : #Substance,
	#superclass : #GafObject,
	#instVars : [
		'comercialName',
		'manufacturer',
		'activeIngredients',
		'withdrawalPeriodRecommendations',
		'unit'
	],
	#category : #'GapAFarm-model'
}

{ #category : #'instance creation' }
Substance class >> isVoyageRoot [
	^ true
]

{ #category : #constants }
Substance class >> units [ 
	^{ 'Kg'. 'L'  }
]

{ #category : #accessing }
Substance >> activeIngredients [
	^ activeIngredients
]

{ #category : #accessing }
Substance >> activeIngredients: anObject [
	activeIngredients := anObject
]

{ #category : #accessing }
Substance >> addActiveIngredient: anActiveIngrediente [
	activeIngredients add: anActiveIngrediente
]

{ #category : #'withdrawal-periods' }
Substance >> addWithdrawalRecommendation: withdrawalPeriodRecommendation [
	withdrawalPeriodRecommendations add: withdrawalPeriodRecommendation
]

{ #category : #accessing }
Substance >> allowedUsage [
	^ withdrawalPeriodRecommendations collect: [ :each | each crop ]
]

{ #category : #testing }
Substance >> canBeSafelyAppliedTo: aCrop [
	"returns true if the substance is exempt for the crop, or the withdrawal time is known"

	^ (SenasaCatalogue singleton isSubstanceExempt: self for: aCrop)
		or: [ (withdrawalPeriodRecommendations
				select: [ :wp | wp crop = aCrop & wp daysToWait notNil ]) notEmpty ]
]

{ #category : #accessing }
Substance >> comercialName [
	^ comercialName
]

{ #category : #accessing }
Substance >> comercialName: anObject [
	comercialName := anObject
]

{ #category : #'withdrawal-periods' }
Substance >> cropsWithDefinedWithdrawalRecommendation [
	^ withdrawalPeriodRecommendations collect: #crop
]

{ #category : #printing }
Substance >> exportToJson [
	| json |
	json:=  
	'{ "comercialName" : "',  comercialName,  '" , ' ,  ' "activeIngredients" : [  '.
	activeIngredients do: [ :each | json:= json,  (each exportToJson), ' , ' ].
	json at: (json size)-1 put: $].
	json:= json ,  ',  "withdrawalPeriodRecommendations": ['.
	withdrawalPeriodRecommendations do: [ :each | json:= json, (each exportToJson), ' , ' ].
	json at: (json size)-1 put: $].
	json:= json, ' }'.
	^json 
]

{ #category : #initialization }
Substance >> initialize [
	super initialize.
	activeIngredients:= OrderedCollection new.
	withdrawalPeriodRecommendations := OrderedCollection new
]

{ #category : #accessing }
Substance >> manufacturer [
	^ manufacturer
]

{ #category : #accessing }
Substance >> manufacturer: anObject [
	manufacturer := anObject
]

{ #category : #copying }
Substance >> postCopy [
	activeIngredients := activeIngredients copy.
	withdrawalPeriodRecommendations := withdrawalPeriodRecommendations
		collect: #copy.
	comercialName := nil
]

{ #category : #printing }
Substance >> printOn: aStream [
	^ aStream
		nextPutAll: (self comercialName).
]

{ #category : #'withdrawal-periods' }
Substance >> removeWithdrawalRecommendation: withdrawalPeriodRecommendation [
	withdrawalPeriodRecommendations
		remove: withdrawalPeriodRecommendation
]

{ #category : #accessing }
Substance >> unit [
	^ unit ifNil: [ 'Kg' ]
]

{ #category : #accessing }
Substance >> unit: anObject [
	unit := anObject
]

{ #category : #'withdrawal-periods' }
Substance >> withdrawalRecommendationFor: aCrop [
	^ withdrawalPeriodRecommendations
		detect: [ :wp | wp crop = aCrop ]
		ifNone: [ nil ]
]

{ #category : #'withdrawal-periods' }
Substance >> withdrawalRecommendations [
	^ withdrawalPeriodRecommendations
]

{ #category : #'withdrawal-periods' }
Substance >> withdrawalRecommendations: anObject [
	withdrawalPeriodRecommendations := anObject
]

{ #category : #'withdrawal-periods' }
Substance >> withdrawalRecommendationsByDays [
	| simplifiedWithdrawalPeriodRecommendations |
	simplifiedWithdrawalPeriodRecommendations := Dictionary new.
	withdrawalPeriodRecommendations
		do: [ :recommendation | 
			(simplifiedWithdrawalPeriodRecommendations
				at: recommendation daysToWait 
				ifAbsentPut: OrderedCollection new) add: recommendation ].
	^ simplifiedWithdrawalPeriodRecommendations
]

{ #category : #'withdrawal-periods' }
Substance >> withdrawalTimeFor: aCrop [
	"Returns the withdrawal time for this substance and the crop. If it should have been specified but it was not, signals MissingWithdrawalInformationException"

	(SenasaCatalogue singleton isSubstanceExempt: self for: aCrop)
		ifTrue: [ ^ 0 ].
	^ ((withdrawalPeriodRecommendations select: [ :wp | wp crop = aCrop ])
		collect: [ :wp | wp daysToWait ])
		ifEmpty: [ (MissingWithdrawalInformationException crop: aCrop substance: self)
				signal ]
		ifNotEmpty: [ :times | times max ]
]
