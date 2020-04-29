Class {
	#name : #ExpertExportComponent,
	#superclass : #ExportComponent,
	#category : #'GapAFarm-ui-expert'
}

{ #category : #callbacks }
ExpertExportComponent >> exportSubstances [
	self
		export:
			(CSVSubstancesExporter events: self session gapAFarm substances)
				export
		inCsvFileNamed: 'fitosanitarios-y-fertilizantes.csv'
]

{ #category : #callbacks }
ExpertExportComponent >> exportSubstancesAsJson [
	self
		export:
			(GAFNeoJsonExporter new
				exportSubstances: self session gapAFarm substances)
		inJsonFileNamed: 'fitosanitarios-y-fertilizantes.json'
]

{ #category : #rendering }
ExpertExportComponent >> renderContentOn: html [
	html table
		class: 'table table-hover';
		with: [ html
				tableHead: [ html
						tableHeading: 'Información';
						tableHeading: 'Formatos disponibles' ].
			html
				tableBody: [ html
						tableRow: [ html
								tableData: 'Fitosanitarios y fertilizantes';
								tableData: [ self renderExportCsvButonFor: #exportSubstances on: html.
									html space.
									self
										renderExportJsonButonFor: #exportSubstancesAsJson
										on: html ] ] ] ]
]
