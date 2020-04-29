Class {
	#name : #PlotsManagementComponentTest,
	#superclass : #GAFComponentTestCase,
	#instVars : [
		'theUser'
	],
	#category : #'GapAFarm-Tests-parasol'
}

{ #category : #elements }
PlotsManagementComponentTest >> addOnePlotButton [
	^ driver findElementByID: 'addOnePlot'
]

{ #category : #scripts }
PlotsManagementComponentTest >> addPlotWithId: plotId [
	(driver findElementByID: 'plotId') sendKeys: plotId.
	(driver findElementByID: 'surface') sendKeys: '1000'.
	self acceptButton click
]

{ #category : #running }
PlotsManagementComponentTest >> componentClass [

	^PlotsManagementComponent 
]

{ #category : #running }
PlotsManagementComponentTest >> setUp [
	GAFStorage inMemory.
	theUser := ParasolHelperForDataPreparation new sampleUser.
	theUser addFarm: (Farm name: 'the farm') save.
	theUser save.
	super setUp
]

{ #category : #tests }
PlotsManagementComponentTest >> testPlotList [
	self assert: self tableContent isEmpty.
	self addOnePlotButton click.
	3 seconds wait.
	self addPlotWithId: '1'.
	self assert: self tableContent equals: '1 1000'
]
