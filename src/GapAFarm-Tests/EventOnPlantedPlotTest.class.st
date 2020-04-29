Class {
	#name : #EventOnPlantedPlotTest,
	#superclass : #HuertasTestCase,
	#instVars : [
		'plot',
		'sowing',
		'event'
	],
	#category : #'GapAFarm-Tests-tests'
}

{ #category : #running }
EventOnPlantedPlotTest >> setUp [
	event := EventOnPlantedPlot new.
	plot := Plot id: 'a' surface: 1.
	tomato := Crop name: 'Tomate' yield: 1.
	potato := Crop name: 'Papa' yield: 1.
	lettuce := Crop name: 'Lechuga' yield: 1.
	sowing := Sowing
		date: Date today
		time: Time now
		plot: nil
		crop: nil
		quantity: 1
		timeToHarvest: 1
		harvestDuration: 1
		expectedYield: 1
]

{ #category : #testing }
EventOnPlantedPlotTest >> testCrop [
	"Move to HarvestingCycle - and use a mock here"

	| applicationBefore applicationInBetween applicationAfter |
	applicationBefore := event copy
		date: '1/1/2020' asDate;
		time: '8:00' asTime;
		yourself.
	applicationInBetween := event copy
		date: '2/15/2020' asDate;
		time: '8:00' asTime;
		yourself.
	applicationAfter := event copy
		date: '3/15/2020' asDate;
		time: '8:00' asTime;
		yourself.
	plot
		addEvent: self potatoSowingFirstOfFebruary;
		addEvent: self lettuceSowingFirstOfMarch;
		addEvent: applicationBefore;
		addEvent: applicationInBetween;
		addEvent: applicationAfter.
	self assert: applicationBefore crop isNil.
	self assert: applicationInBetween crop equals: potato.
	self assert: applicationAfter crop equals: lettuce
]

{ #category : #testing }
EventOnPlantedPlotTest >> testPlot [
   "tomatoSowingFirstOfJanary"


	self assert: event plot isNil.
	self assert: event crop isNil.
	event dateAndTime: DateAndTime now.
	plot
		addEvent:
			(sowing copy
				date: Date yesterday;
				time: '12:00' asTime;
				crop: potato;
				yourself).
	plot addEvent: event.
	self assert: event plot equals: plot.
	self assert: event crop equals: potato
]
