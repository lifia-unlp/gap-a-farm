Class {
	#name : #Farm,
	#superclass : #GafObject,
	#instVars : [
		'name',
		'plots',
		'inventoryItems',
		'sales',
		'harvestingUnits'
	],
	#category : #'GapAFarm-model'
}

{ #category : #testing }
Farm class >> isVoyageRoot [
	^ true
]

{ #category : #'instance creation' }
Farm class >> name: aName [
	^ self new
		name: aName;
		yourself
]

{ #category : #accessing }
Farm >> addInventoryItem: anObject [
	inventoryItems add: anObject
]

{ #category : #accessing }
Farm >> addPlot: anObject [
	plots add: anObject
]

{ #category : #accessing }
Farm >> addSale: anObject [
	sales add: anObject
]

{ #category : #events }
Farm >> aplications [
	^ plots flatCollect: [ :each | each aplications ]
]

{ #category : #utility }
Farm >> dateOfLatestEvent [
	^ ((self plots collect: #dateOfLatestEvent) copyWithout: nil)
		ifEmpty: [ nil ]
		ifNotEmpty: [ :it | it max ]
]

{ #category : #accessing }
Farm >> events [ 
	^ ((self plots) flatCollect: [ :plot | plot events ]) asSortedCollection: [ :a :b | a date > b date ]
]

{ #category : #utility }
Farm >> frequentelyApplied [
	^ plots flatCollect: #frequentelyApplied as: Bag
]

{ #category : #utility }
Farm >> frequentelyHarvested [
	^ plots flatCollect: #frequentelyHarvested as: Bag
]

{ #category : #utility }
Farm >> frequentelyPlanted [
	^ plots flatCollect: #frequentelyPlanted as: Bag
]

{ #category : #accessing }
Farm >> harvestingUnits [
	^ harvestingUnits
]

{ #category : #accessing }
Farm >> harvestingUnits: anObject [
	harvestingUnits := anObject
]

{ #category : #events }
Farm >> harvestings [ 
	^ self plots flatCollect: [ :each | each harvests ]
]

{ #category : #testing }
Farm >> haveEventIn: events [
	^events detect: [ :each | (self events) includes: each  ] ifFound: [ ^true ] ifNone: [ ^false ]  
]

{ #category : #testing }
Farm >> haveSowingsIn: sowings [
	^sowings detect: [ :each | (self sowings) includes: each  ] ifFound: [ ^true ] ifNone: [ ^false ]  
]

{ #category : #initialization }
Farm >> initialize [
	super initialize.
	plots := OrderedCollection new.
	inventoryItems := OrderedCollection new.
	sales := OrderedCollection new.
	harvestingUnits := Harvesting units copy.
]

{ #category : #accessing }
Farm >> inventoryItems [
	^ inventoryItems 
]

{ #category : #testing }
Farm >> isPlotIdInUse: anId byOtherThan: aPlot [
	| nameMatches |
	nameMatches := plots select: [ :each | each id = anId ].
	^ nameMatches anySatisfy: [ :each | each ~= aPlot ]
]

{ #category : #utility }
Farm >> mostFrequentelyHarvested: count [
	^ ((plots flatCollect: #frequentelyHarvested as: Bag) sortedCounts
		collect: #value)
		ifNotEmpty: [ :it | it first: (count min: it size) ]
		ifEmpty: [ Array new ]
]

{ #category : #utility }
Farm >> mostFrequentelyPlanted: count [
	^ ((plots flatCollect: #frequentelyPlanted as: Bag) sortedCounts
		collect: #value)
		ifNotEmpty: [ :it | it first: (count min: it size) ]
		ifEmpty: [ Array new ]
]

{ #category : #accessing }
Farm >> name [
	^ name
]

{ #category : #accessing }
Farm >> name: anObject [
	name := anObject
]

{ #category : #accessing }
Farm >> plots [
	^ plots
]

{ #category : #accessing }
Farm >> plotsWithSowing [
	^ plots reject: [ :plot | plot currentCycle latestSowing isNil ]
]

{ #category : #events }
Farm >> problems [
	^ self plots flatCollect: [ :each | each problems ]
]

{ #category : #accessing }
Farm >> sales [
	^ sales
]

{ #category : #events }
Farm >> sowings [  
	^ self plots flatCollect: [ :each | each sowings ]
]

{ #category : #accessing }
Farm >> updateStockOf: substance with: item [ 
	substance updateStock: item
	
]
