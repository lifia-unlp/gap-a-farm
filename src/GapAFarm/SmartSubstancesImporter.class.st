"
Be very carefull with this. Try only in an empty db.

   | substances |
	substances := GAFNeoJsonExporter new
		importSubstances:
			'/Users/alejandrofernandez/Downloads/fitosanitarios-y-fertilizantes-mariana.json'
				asFileReference.
	SmartSubstancesImporter new carefullyImportAndSaveToMongo: substances
"
Class {
	#name : #SmartSubstancesImporter,
	#superclass : #Object,
	#instVars : [
		'crops',
		'substances',
		'ingredients'
	],
	#category : #'GapAFarm-export'
}

{ #category : #'carefully importing' }
SmartSubstancesImporter >> carefullyImportAndSaveToMongo: aCollectionOfSubstances [
	aCollectionOfSubstances do: [ :each | self importSubstance: each ]
]

{ #category : #'carefully importing' }
SmartSubstancesImporter >> importCrop: aCropToImport [
	crops
		at: aCropToImport vulgarName
		ifAbsentPut: [ Crop new
				vulgarName: aCropToImport vulgarName;
				optimalYieldPerPlant: aCropToImport optimalYieldPerPlant;
				save;
				yourself ]
]

{ #category : #'carefully importing' }
SmartSubstancesImporter >> importIngredient: anIngredientToImport [
	ingredients
		at: anIngredientToImport tradeName
		ifAbsentPut: [ ActiveIngredient new
				tradeName: anIngredientToImport tradeName;
				referenceUrl: anIngredientToImport referenceUrl;
				save;
				yourself ]
]

{ #category : #'carefully importing' }
SmartSubstancesImporter >> importSubstance: aSubstanceToImport [
	| recommendations substance |
	(substances includesKey: aSubstanceToImport comercialName)
		ifTrue: [ ^ self ].
	aSubstanceToImport activeIngredients
		do:
			[ :anIngredientToImport | self importIngredient: anIngredientToImport ].
	(aSubstanceToImport withdrawalRecommendations
		collect: [ :each | each crop ])
		do: [ :aCrop | self importCrop: aCrop ].
	recommendations := aSubstanceToImport withdrawalRecommendations
		collect: [ :each | 
			WithdrawalRecommendation new
				daysToWait: each daysToWait;
				crop: (crops at: each crop vulgarName);
				referenceUrl: each referenceUrl;
				save;
				yourself ].
	substance := Substance new.
	substance comercialName: aSubstanceToImport comercialName.
	substance
		activeIngredients:
			(aSubstanceToImport activeIngredients
				collect: [ :each | ingredients at: each tradeName ]).
	recommendations
		do: [ :each | substance addWithdrawalRecommendation: each ].
	substance save
]

{ #category : #initialization }
SmartSubstancesImporter >> initialize [
	crops := Dictionary new.
	substances := Dictionary new.
	ingredients := Dictionary new.
]
