Class {
	#name : #HuertasTestCase,
	#superclass : #TestCase,
	#instVars : [
		'lettuce',
		'potato',
		'tomato'
	],
	#category : #'GapAFarm-Tests-tests'
}

{ #category : #data }
HuertasTestCase >> lettuceSowingFirstOfMarch [
	^ Sowing
		date: '3/1/2020' asDate
		time: '00:00' asTime
		plot: nil
		crop: lettuce
		quantity: 1
		timeToHarvest: 1
		harvestDuration: 1
		expectedYield: 1
]

{ #category : #data }
HuertasTestCase >> potatoSowingFirstOfFebruary [
	^ Sowing
		date: '2/1/2020' asDate
		time: '00:00' asTime
		plot: nil
		crop: potato
		quantity: 1
		timeToHarvest: 1
		harvestDuration: 1
		expectedYield: 1
]

{ #category : #data }
HuertasTestCase >> tomatoSowingFirstOfJanuary [
	^ Sowing
		date: '1/1/2020' asDate
		time: '00:00' asTime
		plot: nil
		crop: tomato
		quantity: 1
		timeToHarvest: 1
		harvestDuration: 1
		expectedYield: 1
]
