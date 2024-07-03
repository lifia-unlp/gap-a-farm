Class {
	#name : #BaselineOfGapAFarm,
	#superclass : #BaselineOf,
	#category : #BaselineOfGapAFarm
}

{ #category : #baselines }
BaselineOfGapAFarm >> baseline: spec [

	<baseline>
	spec for: #common do: [
		self
			neoCSV: spec;
			neoJSON: spec;
			voyage: spec;
			seaside: spec;
			bootstrap4: spec;
			telebots: spec;
			mustache: spec;
			mustacheLibrary: spec;
			openAiPapi: spec.
		spec
			package: 'GapAFarm'
			with: [
			spec requires: #( 'Seaside3' 'Bootstrap4-Core' 'Voyage' 'NeoCSV' ) ] ]
]

{ #category : #baselines }
BaselineOfGapAFarm >> bootstrap4: spec [
	spec
		package: 'Bootstrap4-Core'
		with: [ spec repository: 'github://astares/Seaside-Bootstrap4:master/src' ].

]

{ #category : #baselines }
BaselineOfGapAFarm >> mustache: spec [

	spec
		baseline: 'Mustache'
		with: [ spec repository: 'github://noha/mustache:v1.2/repository' ]
]

{ #category : #baselines }
BaselineOfGapAFarm >> mustacheLibrary: spec [

	spec
		baseline: 'MustacheLibrary'
		with: [ spec repository: 'github://casco/mustache-library:main'.
			spec requires: #( 'Mustache' ) ]
]

{ #category : #baselines }
BaselineOfGapAFarm >> neoCSV: spec [
	spec
		baseline: 'NeoCSV'
		with: [ spec repository: 'github://svenvc/NeoCSV/repository' ]
]

{ #category : #baselines }
BaselineOfGapAFarm >> neoJSON: spec [
	spec
		project: 'NeoJSON'
		with: [ spec
				className: 'ConfigurationOfNeoJSON';
				versionString: #stable;
				repository: 'github://svenvc/NeoJSON/repository' ]
]

{ #category : #baselines }
BaselineOfGapAFarm >> openAiPapi: spec [

	spec
		package: 'OpenAI-Speech'
		with: [ spec repository: 'github://casco/openai-papi:main' ].
	spec
		package: 'OpenAI-API'
		with: [ spec repository: 'github://casco/openai-papi:main' ]
]

{ #category : #baselines }
BaselineOfGapAFarm >> seaside: spec [
	spec
		baseline: 'Seaside3'
		with: [ spec repository: 'github://SeasideSt/Seaside:master/repository' ].
	spec
		package: 'Seaside-REST-Core'
		with: [ spec repository: 'github://SeasideSt/Seaside:master/repository' ]

]

{ #category : #baselines }
BaselineOfGapAFarm >> telebots: spec [

	spec baseline: 'Telebots' with: [
		spec repository: 'github://casco/telebots'.
		spec requires: #( 'OpenAI-Speech' 'OpenAI-Speech' ) ]
]

{ #category : #baselines }
BaselineOfGapAFarm >> voyage: spec [

	spec baseline: 'Voyage' with: [ 
		spec
			loads: #( mongo );
			repository: 'github://pharo-nosql/voyage/mc' ]
]
