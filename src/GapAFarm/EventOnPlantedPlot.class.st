Class {
	#name : #EventOnPlantedPlot,
	#superclass : #Event,
	#category : #'GapAFarm-model'
}

{ #category : #accessing }
EventOnPlantedPlot >> plot: aPlot [
	super plot: aPlot.
	aPlot ifNil: [ ^ self ].
	crop := aPlot cropAtDateAndTime: dateAndTime
]
