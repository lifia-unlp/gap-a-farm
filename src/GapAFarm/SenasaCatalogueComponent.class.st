Class {
	#name : #SenasaCatalogueComponent,
	#superclass : #GAFAbstractTableWithFilterAndActionsComponent,
	#category : #'GapAFarm-ui-common'
}

{ #category : #rendering }
SenasaCatalogueComponent >> columnHeadings [
	^ {'Cultivo' . 'Principio activo' . 'Aptitud' . 'RMP' . 'Fuente'}
]

{ #category : #rendering }
SenasaCatalogueComponent >> columnValuesFor: element [
	"{'Cultivo' . 'Principio activo' . 'Aptitud' . 'RMP' . 'Fuente'}"

	^ {(element cropVulgarName ifEmpty: [ 'Todos' ]).
	element activeIngredientTradeName.
	element applicabilities asCommaString.
	(element residue
		ifNil: [ 'Exento' ]
		ifNotNil: [ :it | it printString ]).
	element source}
]

{ #category : #accessing }
SenasaCatalogueComponent >> elements [
	^ SenasaCatalogue singleton records
		asSortedCollection: [ :a :b | a cropVulgarName < b cropVulgarName ]
]

{ #category : #rendering }
SenasaCatalogueComponent >> renderContentOn: html [
	super renderContentOn: html.
	html small
		class: 'text-muted';
		with: [ html
				text: 'El contenido de esta lista se tomó de las resoluciones '.
			html anchor
				url:
					'http://www.senasa.gob.ar/normativas/resolucion-934-2010-senasa-servicio-nacional-de-sanidad-y-calidad-agroalimentaria';
				target: '_blank';
				with: 'RESOLUCIÓN-608-2012-SENASA'.
			html text: ' y '.
			html anchor
				url: 'http://www.senasa.gob.ar/resolucion-6082012';
				with: 'RESOLUCIÓN-934-2010-SENASA'.
				html text: '. Se corrigieron algunos errores ortográficos. Cuando en el anexo de la resolución no se indica cultivo, se asume que vale para todos. Cuando en el añexo de la resolución no se indica RMP (residuo máximo permitido) se asume "exento".' ]
]
