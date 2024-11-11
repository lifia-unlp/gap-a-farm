Class {
	#name : #GptDataExtractor,
	#superclass : #ChatClient,
	#category : #'GapAFarm-telegram'
}

{ #category : #'prompt-building' }
GptDataExtractor >> basicPromptFor: aFarm [

	| mustacheTemplate |
	mustacheTemplate := GAFMustacheLibrary new
		                    harvestMessageExtractionPrompt
		                    asMustacheTemplate.
	^ mustacheTemplate value:
		  (self buildHarvestingTemplateContextWith: aFarm)
]

{ #category : #'prompt-building' }
GptDataExtractor >> buildHarvestingTemplateContextWith: aFarm [

	^ Dictionary new
		  at: 'crops' put: (self cropsFor: aFarm);
		  at: 'plots' put: (self plotsFor: aFarm);
		  "at: 'units' put: (self unitsFor: aFarm);"
		  at: 'example-crop' put: (self exampleCropFor: aFarm);
		  "at: 'example-unit' put: (self exampleUnitFor: aFarm);"
		  at: 'example-plot' put: (self examplePlotFor: aFarm);
		  yourself
]

{ #category : #'prompt-building' }
GptDataExtractor >> cropsFor: aFarm [

	| stream |
	stream := String new writeStream.
	aFarm frequentelyPlanted
		do: [ :crop | stream nextPutAll: crop vulgarName ]
		separatedBy: [ stream nextPutAll: ', ' ].
	^ stream contents
]

{ #category : #'prompt-building' }
GptDataExtractor >> exampleCropFor: aFarm [

	^ aFarm frequentelyPlanted anyOne vulgarName
]

{ #category : #'prompt-building' }
GptDataExtractor >> examplePlotFor: aFarm [

	^ aFarm plots first id
]

{ #category : #'prompt-building' }
GptDataExtractor >> exampleUnitFor: aFarm [

	^ aFarm harvestingUnits first
]

{ #category : #'as yet unclassified' }
GptDataExtractor >> extractCommandFrom: aString [

	| response responseAsDictionary |
	self acceptMessageFromUser:
		GAFBotMessageTemplateFactory new promptExtractCommand.
	self acceptMessageFromUser: aString.
	self askAssistantToContribute.
	response := self lastMessage at: 'content'.
	responseAsDictionary := [ NeoJSONReader fromString: response ]
		                        on: Error
		                        do: [ Dictionary new ].
	^ responseAsDictionary
]

{ #category : #api }
GptDataExtractor >> extractHarvestingParametersFrom: aString for: aFarm [

	| response responseAsDictionary |
	self acceptMessageFromUser: (self basicPromptFor: aFarm).
	self acceptMessageFromUser: aString.
	self askAssistantToContribute.
	response := self lastMessage at: 'content'.
	responseAsDictionary := [ NeoJSONReader fromString: response ]
		                        on: Error
		                        do: [ Dictionary new ].
	^ responseAsDictionary
]

{ #category : #'as yet unclassified' }
GptDataExtractor >> extractParametersFrom: aString [

	| response responseAsDictionary |
	self acceptMessageFromUser: aString.
	self askAssistantToContribute.
	response := self lastMessage at: 'content'.
	responseAsDictionary := [ NeoJSONReader fromString: response ]
		                        on: Error
		                        do: [ Dictionary new ].
	^ responseAsDictionary
]

{ #category : #'as yet unclassified' }
GptDataExtractor >> extractUpdateHarvestingParametersFrom: aString for: aFarm [

	self acceptMessageFromUser: (self updateHarvestingPromptFor: aFarm).
	^ self extractParametersFrom: aString
]

{ #category : #'as yet unclassified' }
GptDataExtractor >> memoryTest [
	
	self acceptMessageFromUser: GAFMustacheLibrary new memoryTestPrompt.
	self askAssistantToContribute.
	^ self lastMessage at: 'content'.
]

{ #category : #'prompt-building' }
GptDataExtractor >> plotsFor: aFarm [

	| stream |
	stream := String new writeStream.
	aFarm plots
		do: [ :plot | stream nextPutAll: plot id ]
		separatedBy: [ stream nextPutAll: ', ' ].
	^ stream contents
]

{ #category : #'prompt-building' }
GptDataExtractor >> unitsFor: aFarm [

	| stream |
	stream := String new writeStream.
	aFarm harvestingUnits
		do: [ :unit | stream nextPutAll: unit ]
		separatedBy: [ stream nextPutAll: ', ' ].
	^ stream contents
]

{ #category : #'as yet unclassified' }
GptDataExtractor >> updateHarvestingPromptFor: aFarm [

	| mustacheTemplate |
	mustacheTemplate := GAFMustacheLibrary new
		                    harvestUpdateMessageExtractionPrompt
		                    asMustacheTemplate.
	^ mustacheTemplate value:
		  (self buildHarvestingTemplateContextWith: aFarm)
]
