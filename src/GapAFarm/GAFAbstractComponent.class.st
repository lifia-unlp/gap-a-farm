"
This
	class abstracts some behaviour common to all FOM UI components such
		as having a parent , style , etc
"
Class {
	#name : #GAFAbstractComponent,
	#superclass : #WAComponent,
	#instVars : [
		'parent',
		'problems',
		'displayTermsAndContitions'
	],
	#category : #'GapAFarm-ui-common'
}

{ #category : #'instance creation' }
GAFAbstractComponent class >> parent: aComponent [
	^ self new
		parent: aComponent;
		yourself
]

{ #category : #dialogs }
GAFAbstractComponent >> confirm: message [
	^ self call: (FOMYesNoDialog message: message)
]

{ #category : #initialization }
GAFAbstractComponent >> initialize [
	super initialize.
	problems := OrderedCollection new.
	displayTermsAndContitions := false
]

{ #category : #accessing }
GAFAbstractComponent >> parent [
	^ parent
]

{ #category : #accessing }
GAFAbstractComponent >> parent: anObject [
	parent := anObject
]

{ #category : #updating }
GAFAbstractComponent >> renderDemoStampOn: html [
	html image
		style: 'position: fixed; bottom: 30px; right: 30px; z-index: 999';
		url: GAFLibrary / #demoPng
	"		class: 'fixed-bottom';"
]

{ #category : #rendering }
GAFAbstractComponent >> renderFooterNoteOn: html [
	html
		container: [ html
				small: [ html
						paragraph: [ html
								text:
									'Este prototipo fue diseñado y desarrollado por investigadores, docentes y alumnos del '.
							html anchor
								url: 'http://www.lifia.info.unlp.edu.ar';
								target: '_blank';
								with:
									'Centro de Investigación LIFIA de la Facultad de Informática de la UNLP'.
							html
								text:
									', y de la cátedra de Horticultura y Floricultura de la Facultad de Ciencias Agrarias y Forestales de la UNLP.';
								space;
								text:
									'Este servidor se encuentra disponible solo por un período limitado, con propósito demostrador. Acceder implica conocer y estár de acuerdo con los '.
							html anchor
								callback: [ self toggleTermsAndConditions ];
								with: 'términos y condiciones de uso' ].
					html
						paragraph: [ html text: 'Este prototypo se '.
							html anchor
								url: 'https://github.com/AndresMarconi/ProyectoHuertas';
								target: '_blank';
								with: 'encuentra disponible'.
							html text: ' bajo licencia GPL3' ] ] ].
	displayTermsAndContitions
		ifFalse: [ ^ self ].
	html horizontalRule.
	html container: [ self renderTermsAndConditionsOn: html ]
]

{ #category : #rendering }
GAFAbstractComponent >> renderTermsAndConditionsOn: html [
	html
		paragraph:
			'GAP-A-Farm (LA APLICACIÓN) es un software experimental, en estado de prototipo, diseñado y construido por docentes, investigadores y estudiantes de la Universidad Nacional de La Plata (EL EQUIPO) con propósitos académicos.'.
	html
		paragraph:
			'EL EQUIPO recomienda que la aplicación de los productos para la protección de cultivos se haga en el marco de las buenas prácticas de agricultura, y en base a las indicaciones y bajo el control de un profesional agrónomo matriculado.'.
	html
		paragraph: [ html strong: 'Aceptación de los términos y condiciones de uso' ].
	html
		paragraph:
			'Al acceder y utilizar LA APLICACIÓN y la información que ofrece, usted acepta seguir las siguientes condiciones y estar obligado a ellas. En caso contrario, deberá abstenerse de utilizar LA APLICACIÓN y la información que ofrece.'.
	html
		paragraph:
			'
1. Se permite a usted al acceso a LA APLICACIÓN, en el rol de participante de una prueba piloto experimental a la que fué invitado por EL EQUIPO, a fin de que utilice la misma por la duración de la prueba, y bajo la condición de que usted o cualquier otra persona usuaria de la misma tomará su propia determinación respecto a la adecuación de la información suministrada previo a su uso.'.
	html
		paragraph:
			'
2. La información ofrecida por LA APLICACIÓN respecto a cultivos, principios activos, productos fitosanitarios, fertilizantes, tiempos de carencia, y buenas prácticas de agricultura, ha sido compilada de buena fé por EL EQUIPO en base a material disponible públicamente. EL EQUIPO no garantiza que la misma sea completa y correcta, y no se hace responsable de cualquier perjuicio o daño que pudiera surgir de la utilización de la misma.'.
	html
		paragraph:
			'3. EL EQUIPO no se compromete a mantener actualizada y/o a corregir la información suministrada por LA APLICACIÓN.'.
	html
		paragraph:
			'
4. EL EQUIPO no se compromete a brindar soporte técnico, ni a garantizar la provisión continua o en algún nivel de calidad del servicio por ningún período, ni a garantizar la integridad o seguridad de los datos que en el mismo sean ingresados.'.
	html
		paragraph:
			'5. En todo momento usted podrá utilizar las funciones de exportación de datos disponibles para descargar, en formato abierto CSV, de los datos que ha ingresado.'.
	html
		paragraph:
			'6. En todo momento usted podrá solicitar al equipo que se elimine de la base de datos del LA APLICACIÓN todo dato por usted ingresado.'.
	html
		paragraph:
			'7. Usted autoriza AL EQUIPO a inspeccionar la información por usted ingresada, y hacer uso de la misma con fines académicos.'.
	html
		paragraph:
			'8. EL EQUIPO se compromete a no divulgar la información por usted ingresada. Todo producto (publicación, reporte, etc.) que se genere partir de analizarla, manipularla, o combinarla será publicado asegurando su anonimidad.'.
	html
		paragraph:
			'9. El código fuente de GAP-A-Farm es código abierto, disponible bajo licencia GPLv3.0.'.
	html
		paragraph:
			'10. EL EQUIPO no recomienda la compra o uso de ninguno de los productos fitosanitarios o fertilizantes incluidos en el el catálogo de LA APLICACIÓN '
]

{ #category : #updating }
GAFAbstractComponent >> rendererClass [
	^ SBSHtmlCanvas
]

{ #category : #utility }
GAFAbstractComponent >> shorten: aString to: maxSize [
	^ aString size > maxSize
		ifTrue: [ (aString copyFrom: 1 to: maxSize) , ' ...' ]
		ifFalse: [ aString ]
]

{ #category : #rendering }
GAFAbstractComponent >> toggleTermsAndConditions [
	displayTermsAndContitions := displayTermsAndContitions not
]

{ #category : #updating }
GAFAbstractComponent >> updateRoot: aWARoot [
	super updateRoot: aWARoot.
	aWARoot
		beHtml5;
		title: 'GAP-a-Farm'.
	aWARoot stylesheet
		url:
			'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css'
]
