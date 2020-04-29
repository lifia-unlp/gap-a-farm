Class {
	#name : #ExampleDataLoaderToShowcaseTheDashboard,
	#superclass : #Object,
	#instVars : [
		'session',
		'lastDay'
	],
	#category : #'GapAFarm-example-data'
}

{ #category : #constants }
ExampleDataLoaderToShowcaseTheDashboard >> activeIngredients [
	| ingredientNames |
	ingredientNames := {'Acelga' . 'Ají' . 'Albahaca' . 'Berenjena'.
	'Espinaca' . 'Lechuga' . 'Pimiento' . 'Rúcula' . 'Tomate'}
		flatCollect:
			[ :each | SenasaCatalogue singleton registeredIngredientsForCropNamed: each ]
		as: Set.
	^ ingredientNames
		collect: [ :tradeName | 
			ActiveIngredient new
				tradeName: tradeName;
				yourself ]
]

{ #category : #loading }
ExampleDataLoaderToShowcaseTheDashboard >> addDemoEvents [
	lastDay := Date today.
	self addEventTomatoInwaitingPeriodTo: (self session farm plots at: 1). 
	self addEventAcelgaToHarvestTo: (self session farm plots at: 2).
	self addEventTomatoInwaitingPeriodTo: (self session farm plots at: 3). 
	self addEventTomatoInwaitingPeriodTo: (self session farm plots at: 11). 
	self addEventTomatoInwaitingPeriodTo: (self session farm plots at: 12). 
	self addEventTomatoInwaitingPeriodTo: (self session farm plots at: 13). 
	self addEventTomatoInwaitingPeriodTo: (self session farm plots at: 14). 
	self addEventAcelgaToHarvestTo: (self session farm plots at: 4).
	self addEventEspinacaInwaitingPeriodTo: (self session farm plots at: 5).	
	self addEventPimientoInHarvestingTo: (self session farm plots at: 7).
	self addEventPimientoInHarvestingTo: (self session farm plots at: 8).
	self addEventAlbahacaInHarvestingTo: (self session farm plots at: 9)
]

{ #category : #loading }
ExampleDataLoaderToShowcaseTheDashboard >> addDemoPlots [
	^ self plots
		do: [ :plot | 
			plot save.
			session farm addPlot: plot.
			session farm save ]
]

{ #category : #constants }
ExampleDataLoaderToShowcaseTheDashboard >> addDemoSubstances [
	| ingredients crops |
	ingredients:= session gapAFarm activeIngredients.
	crops:= session gapAFarm crops.
	self 
		addSubstance: (ingredients at: 4) to: (crops at: 9) with: 10;
		addSubstance: (ingredients at: 3) to: (crops at: 1) with: 3;
		addSubstance: (ingredients at: 10) to: (crops at: 5) with: 21.		
]

{ #category : #adding }
ExampleDataLoaderToShowcaseTheDashboard >> addDemoUsers [
	1 to: 5
		do: [ :num | 
			| user farm |
			lastDay := Date today.
			user := GAFUser new.
			user email: 'user', num asString.
			farm := Farm name: 'granja de ',user email.
			self plots
				do: [ :each | 
					farm addPlot: each.
					each save ].
			self addProblemsTo: farm plots.
			farm problems do: [ :each | each save ].
			user addFarm: farm.
			farm save.
			user save ]
]

{ #category : #loading }
ExampleDataLoaderToShowcaseTheDashboard >> addEventAcelgaToHarvestTo: aPlot [
	| crop sowing harvesting |
	crop := session gapAFarm crops
		detect: [ :each | each vulgarName = 'Acelga' ].
	sowing := Sowing
		date: (lastDay subtractDays: 29)
		time: '12:00' asTime
		plot: aPlot
		crop: crop
		quantity: (Measurement magnitude: 1000 unit: 'Plantas')
		timeToHarvest: 30
		harvestDuration: 4
		expectedYield: 2000.
	harvesting := Harvesting
		date: (lastDay subtractDays: 1)
		time: '18:00' asTime
		plot: aPlot
		crop: crop
		quantity: 1000.
	aPlot
		addEvent: sowing;
		addEvent: harvesting.
	sowing save.
	harvesting save.
	aPlot save
]

{ #category : #loading }
ExampleDataLoaderToShowcaseTheDashboard >> addEventAlbahacaInHarvestingTo: aPlot [
	| crop sowing harvesting |
	crop := session gapAFarm crops
		detect: [ :each | each vulgarName = 'Albahaca' ].
	sowing := Sowing
		date: (lastDay subtractDays: 40)
		time: '12:00' asTime
		plot: aPlot
		crop: crop
		quantity: (Measurement magnitude: 1000 unit: 'Plantas')
		timeToHarvest: 38
		harvestDuration: 10
		expectedYield: 2000.
	harvesting := Harvesting
		date: (lastDay subtractDays: 1)
		time: '18:00' asTime
		plot: aPlot
		crop: crop
		quantity: 1000.
	aPlot
		addEvent: sowing;
		addEvent: harvesting.
	sowing save.
	harvesting save.
	aPlot save
]

{ #category : #loading }
ExampleDataLoaderToShowcaseTheDashboard >> addEventEspinacaInwaitingPeriodTo: aPlot [
	| crop substance sowing problem application |
	crop := session gapAFarm crops
		detect: [ :each | each vulgarName = 'Espinaca' ].
	substance := session gapAFarm substances at: 3.
	sowing := Sowing
		date: (lastDay subtractDays: 30)
		time: '18:00' asTime
		plot: aPlot
		crop: crop
		quantity: (Measurement magnitude: 1000 unit: 'Plantas')
		timeToHarvest: 40
		harvestDuration: 7
		expectedYield: 2000.
	problem := AdversityReport
		date: (lastDay subtractDays: 15)
		time: '18:00' asTime
		plot: aPlot
		description: 'Alternaria'
		types: {AdversityReport types second}.
	application := Application
		date: (lastDay subtractDays: 10)
		time: '18:00' asTime
		plot: aPlot
		substance: substance
		quantity: 2
		machine: '1'.
	aPlot
		addEvent: sowing;
		addEvent: application;
		addEvent: problem.
	sowing save.
	problem save.
	application save.
	aPlot save
]

{ #category : #loading }
ExampleDataLoaderToShowcaseTheDashboard >> addEventPimientoInHarvestingTo: aPlot [
	| crop sowing harvesting |
	crop := session gapAFarm crops
		detect: [ :each | each vulgarName = 'Pimiento' ].
	sowing := Sowing
		date: (lastDay subtractDays: 25)
		time: '12:00' asTime
		plot: aPlot
		crop: crop
		quantity: (Measurement magnitude: 1000 unit: 'Plantas')
		timeToHarvest: 22
		harvestDuration: 10
		expectedYield: 2000.
	harvesting := Harvesting
		date: (lastDay subtractDays: 2)
		time: '18:00' asTime
		plot: aPlot
		crop: crop
		quantity: 1000.
	aPlot
		addEvent: sowing;
		addEvent: harvesting.
	sowing save.
	harvesting save.
	aPlot save
]

{ #category : #loading }
ExampleDataLoaderToShowcaseTheDashboard >> addEventTomatoInwaitingPeriodTo: aPlot [
	| crop substance sowing problem application |
	crop := session gapAFarm crops
		detect: [ :each | each vulgarName = 'Tomate' ].
	substance := session gapAFarm substances at: 2.
	sowing := Sowing
		date: (lastDay subtractDays: 45) 
		time: '18:00' asTime
		plot: aPlot
		crop: crop
		quantity: (Measurement magnitude: 1000 unit: 'Plantas')
		timeToHarvest: 50
		harvestDuration: 7
		expectedYield: 2000.
	problem := AdversityReport
		date: (lastDay subtractDays: 5)
		time: '18:00' asTime
		plot: aPlot
		description: 'Pulgón'
		types: {AdversityReport types first}.
	application := Application
		date: (lastDay subtractDays: 2)
		time: '18:00' asTime
		plot: aPlot
		substance: substance
		quantity: 2
		machine: '1'
		.
	aPlot
		addEvent: sowing;
		addEvent: application;
		addEvent: problem.
	sowing save.
	problem save.
	application save.
	aPlot save
]

{ #category : #loading }
ExampleDataLoaderToShowcaseTheDashboard >> addExpertDemoData [
	session gapAFarm crops ifEmpty: [ self crops do: #save ].
	session gapAFarm activeIngredients
		ifEmpty: [ self activeIngredients do: #save ].
	session gapAFarm substances ifEmpty: [ self addDemoSubstances ].
	self addDemoUsers
]

{ #category : #loading }
ExampleDataLoaderToShowcaseTheDashboard >> addFarmerDemoData [
	session gapAFarm crops ifEmpty: [ self addExpertDemoData ].
	session farm plots ifEmpty: [ self addDemoPlots ].
	self addSubstancesToInventory.
	self addDemoEvents.


]

{ #category : #adding }
ExampleDataLoaderToShowcaseTheDashboard >> addProblemsTo: plots [
	(plots at: 1)
		addEvent:
			(AdversityReport
				date: (lastDay subtractDays: 5)
				time: '18:00' asTime
				plot: (plots at: 1)
				description: 'Pulgón'
				types: {AdversityReport types first}).
	(plots at: 2)
		addEvent:
			(AdversityReport
				date: (lastDay subtractDays: 5)
				time: '18:00' asTime
				plot: (plots at: 2)
				description: 'Mosca blanca'
				types: {AdversityReport types fourth}).
	(plots at: 3)
		addEvent:
			(AdversityReport
				date: (lastDay subtractDays: 10)
				time: '18:00' asTime
				plot: (plots at: 3)
				description: 'Pulgón'
				types: {AdversityReport types first}).
	(plots at: 4)
		addEvent:
			(AdversityReport
				date: (lastDay subtractDays: 10)
				time: '18:00' asTime
				plot: (plots at: 4)
				description: 'Mosca blanca'
				types: {AdversityReport types fourth}).
	(plots at: 5)
		addEvent:
			(AdversityReport
				date: (lastDay subtractDays: 5)
				time: '18:00' asTime
				plot: (plots at: 5)
				description: 'Alternaria'
				types: {AdversityReport types second}).
	(plots at: 7)
		addEvent:
			(AdversityReport
				date: (lastDay subtractDays: 5)
				time: '18:00' asTime
				plot: (plots at: 7)
				description: 'Alternaria'
				types: {AdversityReport types second}).
	(plots at: 8)
		addEvent:
			(AdversityReport
				date: (lastDay subtractDays: 5)
				time: '18:00' asTime
				plot: (plots at: 8)
				description: 'Alternaria'
				types: {AdversityReport types second})
]

{ #category : #constants }
ExampleDataLoaderToShowcaseTheDashboard >> addSubstance: ingredient to: crop with: days [
	| substance |
	substance := Substance new
		comercialName: 'Preparado de ' , ingredient tradeName;
		addActiveIngredient: ingredient.
	substance addWithdrawalRecommendation:
		(WithdrawalRecommendation
		daysToWait: days
		crop: crop
		referenceUrl: '') .
	substance save.
	^substance 
]

{ #category : #loading }
ExampleDataLoaderToShowcaseTheDashboard >> addSubstancesToInventory [
	Substance selectAll
		do: [ :each | 
			self session farm
				addInventoryItem:
					(InventoryItem new
						substance: each;
						save;
						yourself) ].
	self session farm save
]

{ #category : #constants }
ExampleDataLoaderToShowcaseTheDashboard >> crops [
	^ {'Acelga' . 'Ají' . 'Albahaca' . 'Berenjena' . 'Espinaca' . 'Lechuga'.
	'Pimiento' . 'Rúcula' . 'Tomate'}
		collect: [ :vulgarName | 
			Crop new
				vulgarName: vulgarName;
				yourself ]
]

{ #category : #constants }
ExampleDataLoaderToShowcaseTheDashboard >> plots [
	^ (1 to: 20)
		collect: [ :each | Plot id: 'A' , each asString surface: 1000 ]
]

{ #category : #accessing }
ExampleDataLoaderToShowcaseTheDashboard >> session [
	^ session
]

{ #category : #accessing }
ExampleDataLoaderToShowcaseTheDashboard >> session: anObject [
	session := anObject
]
