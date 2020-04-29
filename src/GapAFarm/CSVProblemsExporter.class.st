Class {
	#name : #CSVProblemsExporter,
	#superclass : #CSVGAFExporter,
	#category : #'GapAFarm-export'
}

{ #category : #exporting }
CSVProblemsExporter >> elementRowFor: anAdversityReport [
	"#('Fecha' 'Hora' 'Lote' 'Tipificación' 'Detalles' 'Notas')"

	^ {anAdversityReport date.
	anAdversityReport time.
	anAdversityReport plot id.
	(anAdversityReport crop
		ifNil: [ '' ]
		ifNotNil: [ :it | it vulgarName ]).
	anAdversityReport adversityTypes asCommaString.
	anAdversityReport descriptionOfAdversities.
	anAdversityReport comment}
]

{ #category : #exporting }
CSVProblemsExporter >> headerRow [
	^ #('Fecha' 'Hora' 'Lote' 'Cultivo' 'Tipificación' 'Detalles' 'Notas')
]
