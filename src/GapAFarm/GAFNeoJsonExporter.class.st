Class {
	#name : #GAFNeoJsonExporter,
	#superclass : #Object,
	#category : #'GapAFarm-export'
}

{ #category : #initialization }
GAFNeoJsonExporter >> configureSchemasAndMappingsFor: aNeoJSONReaderOrWriter [
	aNeoJSONReaderOrWriter
		mapInstVarsFor: ActiveIngredient;
		mapInstVarsFor: Crop;
		mapInstVarsFor: WithdrawalRecommendation;
		for: WithdrawalRecommendation
			do: [ :mapping | (mapping mapInstVar: #crop) valueSchema: Crop ];
		for: #OrderedCollectionOfActiveIngredient
			customDo: [ :mapping | 
			mapping
				listOfType: OrderedCollection
				andElementSchema: ActiveIngredient ];
		for: #OrderedCollectionOfWithdrawalRecommendation
			customDo: [ :mapping | 
			mapping
				listOfType: OrderedCollection
				andElementSchema: WithdrawalRecommendation ];
		mapInstVarsFor: Substance;
		for: Substance
			do: [ :mapping | 
			(mapping mapInstVar: #activeIngredients)
				valueSchema: #OrderedCollectionOfActiveIngredient.
			(mapping mapInstVar: #withdrawalPeriodRecommendations)
				valueSchema: #OrderedCollectionOfWithdrawalRecommendation ];
		for: #OrderedCollectionOfSubstance
			customDo:
				[ :mapping | mapping listOfType: OrderedCollection andElementSchema: Substance ]
]

{ #category : #export }
GAFNeoJsonExporter >> exportSubstances: aCollectionOfSubstances [
	| writer |
	^ String
		streamContents: [ :stream | 
			writer := NeoJSONWriter on: stream.
			self configureSchemasAndMappingsFor: writer.
			writer prettyPrint: true.
			writer nextPut: aCollectionOfSubstances ]
]

{ #category : #export }
GAFNeoJsonExporter >> importSubstances: aJSONString [
	"Careful! reacreates all objects, does not pay attention to identities, does not persist"

	| reader |
	reader := NeoJSONReader on: aJSONString readStream.
	self configureSchemasAndMappingsFor: reader.
	^ reader nextAs: #OrderedCollectionOfSubstance
]
