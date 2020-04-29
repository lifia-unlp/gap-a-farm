Class {
	#name : #CSVSowingsExporter,
	#superclass : #CSVGAFExporter,
	#category : #'GapAFarm-export'
}

{ #category : #exporting }
CSVSowingsExporter >> elementRowFor: aSowing [
	"#('Fecha' 'Hora' 'Lote' 'Cultivo' 'Variedad (cultivar)' 'Cantidad' 'Tiempo estimado para cosechar' 'Duración estimada de la cosecha' 'Rendimiento total esperado' 'Notas')"

	^ {aSowing date.
	aSowing time.
	aSowing plot id.
	aSowing crop vulgarName.
	aSowing cultivarName.
	aSowing quantity printString.
	aSowing timeToHarvest.
	aSowing harvestDuration.
	aSowing expectedYield.
	aSowing comment}
]

{ #category : #exporting }
CSVSowingsExporter >> headerRow [
	^ #('Fecha' 'Hora' 'Lote' 'Cultivo' 'Variedad (cultivar)' 'Cantidad' 'Tiempo estimado para cosechar' 'Duración estimada de la cosecha' 'Rendimiento total esperado' 'Notas')
]
