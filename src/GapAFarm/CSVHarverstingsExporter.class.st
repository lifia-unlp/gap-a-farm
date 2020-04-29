Class {
	#name : #CSVHarverstingsExporter,
	#superclass : #CSVGAFExporter,
	#category : #'GapAFarm-export'
}

{ #category : #exporting }
CSVHarverstingsExporter >> elementRowFor: aSowing [
	"#('Fecha' 'Hora' 'Lote' 'Cantidad (Kg)' 'Cantidad (otra unidad)' 'Cultivo' 'Variedad (cultivar)' 'Notas')"

	^ {aSowing date.
	aSowing time.
	aSowing plot id.
	aSowing quantity printString.
	aSowing otherUnit printString.
	aSowing crop vulgarName.
	aSowing cultivarName.
	aSowing comment}
]

{ #category : #exporting }
CSVHarverstingsExporter >> headerRow [
	^ #('Fecha' 'Hora' 'Lote' 'Cantidad (Kg)' 'Cantidad (otra unidad)' 'Cultivo' 'Variedad (cultivar)' 'Notas')
]
