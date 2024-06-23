Class {
	#name : #GptDataExtractor,
	#superclass : #ChatClient,
	#category : #'GapAFarm-telegram'
}

{ #category : #api }
GptDataExtractor >> extractHarvestingParametersFrom: aString [

	| response responseAsDictionary |
	self acceptMessageFromUser:
		GAFMustacheLibrary new harvestMessageExtractionPrompt.
	self acceptMessageFromUser: aString.
	response := self askAssistantToContribute.
	responseAsDictionary := [ NeoJSONReader fromString: response ]
		                        on: Error
		                        do: [ Dictionary new ].
	^ responseAsDictionary
]
