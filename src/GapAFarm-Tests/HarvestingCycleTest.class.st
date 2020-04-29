Class {
	#name : #HarvestingCycleTest,
	#superclass : #HuertasTestCase,
	#instVars : [
		'event',
		'sowing',
		'harvestingCycle',
		'plot'
	],
	#category : #'GapAFarm-Tests-tests'
}

{ #category : #running }
HarvestingCycleTest >> setUp [
	event := EventOnPlantedPlot new.
	plot := Plot id: 'a' surface: 1.
	harvestingCycle := HarvestingCycle new.
	potato := Crop name: 'Papa' yield: 1.
	lettuce := Crop name: 'Lechuga' yield: 1.


]

{ #category : #testing }
HarvestingCycleTest >> testAddEvent_doNotRestartOnSameSowing [
	| tomatoSowingFirstOfJanuary tomatoSecondOfJanuary |
	self assert: plot currentCycle events isEmpty.
	tomatoSowingFirstOfJanuary := self tomatoSowingFirstOfJanuary.
	tomatoSecondOfJanuary := self tomatoSowingFirstOfJanuary
		date: '1/2/2020' asDate;
		yourself.
	plot
		addEvent: tomatoSowingFirstOfJanuary;
		addEvent: tomatoSecondOfJanuary.
	self
		assertCollection: plot currentCycle events
		equals:
			{tomatoSowingFirstOfJanuary.
			tomatoSecondOfJanuary} asOrderedCollection
]

{ #category : #testing }
HarvestingCycleTest >> testAddEvent_ignoreOlderThanLatestSowing [
	| tomatoSowingFirstOfJanuary potatoSowingFirstOfFebruary |
	self assert: plot currentCycle events isEmpty.
	tomatoSowingFirstOfJanuary := self tomatoSowingFirstOfJanuary.
	potatoSowingFirstOfFebruary := self potatoSowingFirstOfFebruary.
	plot addEvent: potatoSowingFirstOfFebruary.
	self
		assertCollection: plot currentCycle events
		equals: {potatoSowingFirstOfFebruary} asOrderedCollection.
	plot addEvent: tomatoSowingFirstOfJanuary.
	self
		assertCollection: plot currentCycle events
		equals: {potatoSowingFirstOfFebruary} asOrderedCollection.

]

{ #category : #testing }
HarvestingCycleTest >> testAddEvent_restartOnNewSowing [
	| tomatoSowingFirstOfJanuary potatoSowingFirstOfFebruary applicationSecondOfJanuary adversitySecondOfJanuary harvestingSecondOfJanuary |
	self assert: plot currentCycle events isEmpty.
	tomatoSowingFirstOfJanuary := self tomatoSowingFirstOfJanuary.
	applicationSecondOfJanuary := Application new
		date: '1/2/2020' asDate;
		yourself.
	adversitySecondOfJanuary := AdversityReport new
		date: '1/2/2020' asDate;
		yourself.
	harvestingSecondOfJanuary := Harvesting new
		date: '1/2/2020' asDate;
		yourself.
	plot
		addEvent: tomatoSowingFirstOfJanuary;
		addEvent: applicationSecondOfJanuary;
		addEvent: adversitySecondOfJanuary;
		addEvent: harvestingSecondOfJanuary.
	self
		assertCollection: plot currentCycle events
		equals:
			{tomatoSowingFirstOfJanuary.
			applicationSecondOfJanuary.
			adversitySecondOfJanuary.
			harvestingSecondOfJanuary} asOrderedCollection.
	potatoSowingFirstOfFebruary := self potatoSowingFirstOfFebruary.
	plot addEvent: potatoSowingFirstOfFebruary.
	self
		assertCollection: plot currentCycle events
		equals: {potatoSowingFirstOfFebruary} asOrderedCollection
]

{ #category : #testing }
HarvestingCycleTest >> testIsOutOfSync [
	"If removing one sowing, the cycle becomes outOfSync"

	| cycle |
	cycle := plot currentCycle.
	self deny: cycle isOutOfSync.
	sowing := self tomatoSowingFirstOfJanuary.
	cycle addEvent: sowing.
	self deny: cycle isOutOfSync.
	cycle removeEvent: sowing.
	self assert: cycle isOutOfSync
]
