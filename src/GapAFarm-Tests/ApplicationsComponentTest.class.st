Class {
	#name : #ApplicationsComponentTest,
	#superclass : #GAFComponentTestCase,
	#instVars : [
		'theUser',
		'theFarm'
	],
	#category : #'GapAFarm-Tests-parasol'
}

{ #category : #running }
ApplicationsComponentTest >> componentClass [

	^ApplicationsComponent  
]

{ #category : #elements }
ApplicationsComponentTest >> doseField [
	^ driver findElementByID: 'dose'
]

{ #category : #elements }
ApplicationsComponentTest >> machineField [
	^ driver findElementByID: 'machine'
]

{ #category : #private }
ApplicationsComponentTest >> plotNames [
	^ theUser farms first plots collect: #id
]

{ #category : #elements }
ApplicationsComponentTest >> productSelector [
	^ driver findElementByID: 'productSelector'
]

{ #category : #elements }
ApplicationsComponentTest >> quantityField [
	^ driver findElementByID: 'quantity'
]

{ #category : #elements }
ApplicationsComponentTest >> reasonSelector [
	^ driver findElementByID: 'reason'
]

{ #category : #running }
ApplicationsComponentTest >> setUp [
	| acetamiprid mospilan |
	GAFStorage inMemory.
	acetamiprid := ActiveIngredient new
		tradeName: 'acetamiprid';
		save;
		yourself.
	mospilan := Substance new
		addActiveIngredient: acetamiprid;
		comercialName: 'Mospilan';
		save;
		yourself.
	theUser := ParasolHelperForDataPreparation new sampleUser.
	theFarm := Farm name: 'the farm'.
	theFarm
		addInventoryItem:
			(InventoryItem new
				substance: mospilan;
				save;
				yourself).
	theFarm
		addPlot: (Plot id: 'A' surface: '1') save;
		addPlot: (Plot id: 'B' surface: '1') save.
	theFarm save.
	theUser addFarm: theFarm.
	theUser save.
	super setUp
]

{ #category : #tests }
ApplicationsComponentTest >> testAddApplication [
	self addButton click.
	3 seconds wait.
	self assert: (self dateField getAttribute: 'value') equals: ''.
	self dateField sendKeys: '01/01/2020'.
	self
		assert: (self dateField getAttribute: 'value')
		equals: '01/01/2020'.
	self timeField sendKeys: '10:00'.
	self assert: (self timeField getAttribute: 'value') equals: '10:00'.
	self
		assertCollection: (self optionsInSelect: self productSelector)
		equals: {'' . 'Mospilan (en existencia: 0 Kg)'}.
	self
		assertCollection: (self optionsInSelect: self plotSelector)
		equals: {'A' . 'B'}
]

{ #category : #tests }
ApplicationsComponentTest >> testEmptyApplicationsList [
	self assert: self tableContent isEmpty.
	
]
