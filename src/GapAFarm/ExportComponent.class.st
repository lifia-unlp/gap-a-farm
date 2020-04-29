Class {
	#name : #ExportComponent,
	#superclass : #GAFAbstractComponent,
	#category : #'GapAFarm-ui-farmer'
}

{ #category : #private }
ExportComponent >> export: data inCsvFileNamed: aFileName [
	self requestContext
		respond: [ :response | 
			response
				contentType: (WAMimeType main: 'text' sub: 'csv');
				document: data;
				attachmentWithFileName: aFileName ]
]

{ #category : #private }
ExportComponent >> export: data inJsonFileNamed: aFileName [
	self requestContext
		respond: [ :response | 
			response
				contentType: WAMimeType applicationJson;
				document: data;
				attachmentWithFileName: aFileName ]
]

{ #category : #rendering }
ExportComponent >> renderExportCsvButonFor: selector on: html [
	html anchor
		callback: [ self perform: selector ];
		with: [ html image url: GAFLibrary / #csvicon48Jpg ]
]

{ #category : #rendering }
ExportComponent >> renderExportJsonButonFor: selector on: html [
	html anchor
		callback: [ self perform: selector ];
		with: [ html image url: GAFLibrary / #jsonicon48Jpg ]
]
