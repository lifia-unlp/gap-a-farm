Class {
	#name : #CSVSubstancesExporter,
	#superclass : #CSVGAFExporter,
	#category : #'GapAFarm-export'
}

{ #category : #exporting }
CSVSubstancesExporter >> elementRowFor: aSubstance [
	"#('Nombre comercial' 'Principios activos' 'Aptitud' 'Carencias' 'Fuentes consultadas')"

	| activeIngredientNames withdrawalPeriodsAsStrings |
	activeIngredientNames := aSubstance activeIngredients
		collect: #tradeName.
	withdrawalPeriodsAsStrings := aSubstance
		withdrawalRecommendations
		collect: [ :each | each crop vulgarName , ': ' , each daysToWait asString ].
	^ {aSubstance comercialName.
	activeIngredientNames asCommaString.
	(SenasaCatalogue singleton
		combinedApplicabilitiesFor: activeIngredientNames) asCommaString.
	withdrawalPeriodsAsStrings asCommaString.
	(aSubstance withdrawalRecommendations
		collect: [ :each | each referenceUrl ]) asCommaString}
]

{ #category : #exporting }
CSVSubstancesExporter >> headerRow [
	^ #('Nombre comercial' 'Principios activos' 'Aptitud' 'Carencias' 'Fuentes consultadas')
]

{ #category : #initialization }
CSVSubstancesExporter >> initialize [
	sortBlock := [ :a :b | a comercialName < b comercialName ]
]
