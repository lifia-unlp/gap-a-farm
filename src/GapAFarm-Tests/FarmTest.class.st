Class {
	#name : #FarmTest,
	#superclass : #TestCase,
	#category : #'GapAFarm-Tests-tests'
}

{ #category : #tests }
FarmTest >> testHasPlantedPlots [

	| farm plot lettuce |
	lettuce := Crop name: 'Lechuga' yield: 1.
	farm := Farm name: 'test'.
	self deny: farm hasPlantedPlots.
	plot := Plot id: '1' surface: 1000.
	farm addPlot: plot.
	self deny: farm hasPlantedPlots.
	plot addEvent: (Sowing
			 date: '3/1/2020' asDate
			 time: '00:00' asTime
			 plot: nil
			 crop: lettuce
			 quantity: 1
			 timeToHarvest: 1
			 harvestDuration: 1
			 expectedYield: 1).
	self assert: farm hasPlantedPlots
]
