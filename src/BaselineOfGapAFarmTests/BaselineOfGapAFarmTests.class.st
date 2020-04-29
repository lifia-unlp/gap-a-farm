Class {
	#name : #BaselineOfGapAFarmTests,
	#superclass : #BaselineOf,
	#category : #BaselineOfGapAFarmTests
}

{ #category : #baselines }
BaselineOfGapAFarmTests >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ self
				parasol: spec;
				mocketry: spec;
				proyectoHuertas: spec.
			spec
				package: 'GapAFarm-Tests'
				with: [ spec requires: #('GapAFarm' 'Parasol' 'Mocketry') ].
			spec postLoadDoIt: #postLoadActions ]
]

{ #category : #baselines }
BaselineOfGapAFarmTests >> mocketry: spec [
	spec
		baseline: 'Mocketry'
		with: [ spec repository: 'github://dionisiydk/Mocketry:v6.0.2' ]
]

{ #category : #baselines }
BaselineOfGapAFarmTests >> parasol: spec [
	spec
		baseline: 'Parasol'
		with: [ spec
				loads: #('tests');
				repository: 'github://SeasideSt/Parasol:master/repository' ]
]

{ #category : #baselines }
BaselineOfGapAFarmTests >> postLoadActions [

	GTPlayground
		edit: ''
	
	label: 'Parasol/Selenium test instructions'.
]

{ #category : #baselines }
BaselineOfGapAFarmTests >> proyectoHuertas: spec [
	spec
		baseline: 'ProyectoHuertas'
		with: [ spec repository: 'github:/AndresMarconi/ProyectoHuertas' ]
]
