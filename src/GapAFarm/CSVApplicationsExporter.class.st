Class {
	#name : #CSVApplicationsExporter,
	#superclass : #CSVGAFExporter,
	#category : #'GapAFarm-export'
}

{ #category : #exporting }
CSVApplicationsExporter >> elementRowFor: anApplication [
	^ {anApplication date.
	anApplication time.
	anApplication plot id.
	(anApplication crop ifNil: [ '' ] ifNotNil: [ :it | it vulgarName ]).
	anApplication substance comercialName.
	anApplication quantity.
	anApplication dose.
	anApplication machine.
	anApplication comment}
]

{ #category : #exporting }
CSVApplicationsExporter >> headerRow [
	^ #('Fecha' 'Hora' 'Lote' 'Cultivo' 'Producto' 'Cantidad' 'Dosificación' 'Maquina' 'Notas')
]
