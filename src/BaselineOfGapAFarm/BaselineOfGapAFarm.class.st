Class {
	#name : #BaselineOfGapAFarm,
	#superclass : #BaselineOf,
	#category : #BaselineOfGapAFarm
}

{ #category : #baselines }
BaselineOfGapAFarm >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ self
				neoCSV: spec;
				neoJSON: spec;
				voyage: spec;
				seaside: spec;
				bootstrap4: spec;
				telebots: spec;
				mustache: spec.
			spec
				package: 'GapAFarm'
				with: [ spec requires: #('Seaside3' 'Bootstrap4-Core' 'Voyage' 'NeoCSV' 'Telebots-Core') ].
 ]
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
BaselineOfGapAFarm >> postLoadActions [

	StPlayground
		openContents: '"To deploy in debug mode use this lines"

GAFDeployer new adminEmail: ''youremail@yourdomain.com''; 
	database: ''gapafarm'';
	deploy.

"Set enableTestDataLoaders: to true to get a [Load demo data] button."
GAFDeployer enableTestDataLoaders: true.
"Set demoMode: to true to get a Demo Banner."
GAFDeployer demoMode: true.

"Evaluate one of the following to set the target persistency strategy"
GAFStorage inMemory.
GAFStorage mongoLocalAt: ''gapafarm''.

"To deploy to production, in a clear image evaluate"

WAAdmin defaultServerManager adaptors
	do: [ :each | WAAdmin defaultServerManager unregister: each ].
ZnZincServerAdaptor startOn: 8080.

(WAAdmin defaultDispatcher handlers keys copyWithoutAll: #(''files''))
	do: [ :appName |
		WAAdmin defaultDispatcher
			unregister: (WAAdmin defaultDispatcher handlerAt: appName) ].
WAAdmin applicationDefaults
	removeParent: WADevelopmentConfiguration instance.

GAFDeployer new
	adminEmail: ''youremail@yourdomain.com'';
	database: ''gapafarm'';
	deploy.
WAAdmin defaultDispatcher defaultName: ''gaf''.

'
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
	spec
		baseline: 'Telebots'
		with: [ spec repository: 'github://casco/telebots' ]
]

{ #category : #baselines }
BaselineOfGapAFarm >> voyage: spec [

	spec baseline: 'Voyage' with: [ 
		spec
			loads: #( mongo );
			repository: 'github://pharo-nosql/voyage/mc' ]
]
