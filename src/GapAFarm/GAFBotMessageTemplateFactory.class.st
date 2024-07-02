"
Each message return a template to be used as explained here: https://book.huihoo.com/smalltalk/pharo/enterprise-pharo/book-result/Mustache/Mustache.html
"
Class {
	#name : #GAFBotMessageTemplateFactory,
	#superclass : #Object,
	#category : #'GapAFarm-telegram'
}

{ #category : #'as yet unclassified' }
GAFBotMessageTemplateFactory >> alertsAsTextMessage: alerts [

	(alerts isEmpty) ifTrue: [ ^'No hay alertas recientes'].
	^ ('Alertas:', Character lf asString, Character lf asString) copyWithAll: 
			(self blogPostsAsTextMessage: alerts).
]

{ #category : #'as yet unclassified' }
GAFBotMessageTemplateFactory >> alertsMessage [

  ^'{{index}}. {{text}} - {{url}}'
]

{ #category : #problems }
GAFBotMessageTemplateFactory >> availableCommands [

 	| stream |
	
	stream := String new writeStream.
	stream nextPutAll: '¿En qué puedo ayudarte?'; lf;
	nextPutAll: '/alertas -> Para ver las alertas disponibles para tu granja.'; lf;
	nextPutAll: '/carencia -> Para ver el listado de lotes actualmente en carencia.'; lf;
	nextPutAll: '/novedades -> Para ver las novedades que aplican a tu granja.'; lf;
	nextPutAll: '/miPredio -> Detalles del estado del predio.'.
	^stream contents.
]

{ #category : #'as yet unclassified' }
GAFBotMessageTemplateFactory >> availableCommandsMiPredio [

	^ 	"'/cultivar -> agregar cultivo en un lote.', Character lf asString,"
		'/cosechar -> registrar cosecha en un lote.'. ", Character lf asString,
		'/registrarAdversidad -> registrar adversidad en un lote.', Character lf asString,
		'/realizarAplicacion -> registrar aplicacion ya efectuada en un lote o solicitar ayuda para solucionar el problema.', Character lf asString,
		'/verLotesEnCarencia -> listado de lotes que aún no pueden utilizarse luego de una aplicación.'."


]

{ #category : #utilities }
GAFBotMessageTemplateFactory >> blogPostsAsTextMessage: blogPosts [

	^ String streamContents: [:stream | blogPosts withIndexDo: [:each :index |
			stream nextPutAll: index asString; nextPutAll: '. ';
					print: each text;
					nextPutAll: ' - ';
					nextPutAll: (each moreInfoUrl isEmpty ifTrue: ['Sin URL']); lf; lf.
			]
		].
]

{ #category : #problems }
GAFBotMessageTemplateFactory >> farmNotSetNotification [

	^'Lo siento, _{{username}}_. No tengo una granja asociada a su usuario de telegram. Solicite al administrador de GAP-a-Farm que le vincule a una granja (para ello indíquele su identificador único de Telegram: *{{id}}*)'
]

{ #category : #'as yet unclassified' }
GAFBotMessageTemplateFactory >> greetingAvailabilityInfoTextMessage [

	^'Cuando necesites de mi ayuda enviame un mensaje. Estoy disponible 24/7!'.
]

{ #category : #'as yet unclassified' }
GAFBotMessageTemplateFactory >> greetingBotDescriptionTextMessage [

	^'Puedo ayudarte a conocer el estado de los lotes de tu predio, brindarte información y ofrecerte recomendaciones.'
]

{ #category : #'as yet unclassified' }
GAFBotMessageTemplateFactory >> greetingConfigSummaryFrecuencyTextMessage [

	^'Seleccioná una de las opciones:', Character lf asString,
	'Diariamente -> una vez por día', Character lf asString,
	'Semanalmente -> una vez a la semana'.
]

{ #category : #'as yet unclassified' }
GAFBotMessageTemplateFactory >> greetingConfigSummaryTextMessage [

	^'Comencemos configurando con qué frecuencia querés recibir mensajes sobre el estado de tu predio.'
]

{ #category : #'as yet unclassified' }
GAFBotMessageTemplateFactory >> greetingTextMessage [

	^'Hola {{username}}. Soy AgroBot, tu nuevo ayudante!'
]

{ #category : #'as yet unclassified' }
GAFBotMessageTemplateFactory >> harvestingConfirmationTextMessage [

	^ 'El lote seleccionado es {{plot}}, con el cultivo {{crop}}. La cosecha fue realizada el día {{date}} a la/s {{hour}}hs, con una cantidad de {{quantity}}KG. La anotación que agregaste es: "{{comment}}" ¿Querés confirmar?'
]

{ #category : #'as yet unclassified' }
GAFBotMessageTemplateFactory >> harvestingPlotConfirmationTextMessage [

	^ 'El lote seleccionado es _{{plot_name}}_ con cultivo {{crop_name}}.'
]

{ #category : #'as yet unclassified' }
GAFBotMessageTemplateFactory >> harvestingPlotsList [

	^ '¿Qué lote deseás cosechar? Ingresá el nombre.', Character lf asString,
	'{{# plots }} 
		{{plot}} con cultivo: {{crop}}', Character lf asString,
	'{{/ plots }}'.
]

{ #category : #'as yet unclassified' }
GAFBotMessageTemplateFactory >> harvestingRequestDateTextMessage [

	^ '¿Qué día realizó la cosecha? Ingrese la fecha en formato día/mes/año.'
]

{ #category : #'as yet unclassified' }
GAFBotMessageTemplateFactory >> newsAsTextMessage: news [

	(news isEmpty) ifTrue: [ ^'No hay novedades para mostrar...'].
	^ ('Novedades:', Character lf asString, Character lf asString) copyWithAll:
			(self blogPostsAsTextMessage: news).
]

{ #category : #utilities }
GAFBotMessageTemplateFactory >> plotsInWithdrawalPeriodAsTextMessage: plots [

	| string |
	(plots isEmpty) ifTrue: [^'No tenés lotes en período de carencia ahora mismo'].
	string := String streamContents: [:stream | 
					stream nextPutAll: '⏳';  
					nextPutAll: 'Estos son tus lotes en carencia y los días que faltan hasta completarse el período.'; lf.
				plots do: [:each |	
					stream nextPutAll: ' - '; nextPutAll: each id; nextPutAll: ': ';
					nextPutAll: (each withdrawalPeriodDaysLeft asString);
					nextPutAll: ((each withdrawalPeriodDaysLeft > 1) 
						ifTrue: [' días.'] ifFalse:	[' día.']); lf.
					].
			].
	^ string contents.
]

{ #category : #'as yet unclassified' }
GAFBotMessageTemplateFactory >> summaryConfigAskHourTextMessage [

	^ 'Bien. Ahora ingresa el horario en el que querés recibir tu resumen con formato 24hs.
Por ejemplo: 06:00 para la mañana o 18:00 para la tarde.'
]

{ #category : #'as yet unclassified' }
GAFBotMessageTemplateFactory >> summaryConfigDayConfirmationTextMessage [

	^ 'El día que indicaste es {{day}}. Si es correcto presiona si. Para seleccionar otro día presiona no.'
]

{ #category : #'as yet unclassified' }
GAFBotMessageTemplateFactory >> summaryConfigHourConfirmationTextMessage [

	^ 'El horario que indicaste es {{hour}}. Si querés cambiar el horario indicado respondé no, caso contrario respondé sí.'
]

{ #category : #'as yet unclassified' }
GAFBotMessageTemplateFactory >> summaryConfigRequestDayTextMessage [

	^ 'Elegí que día de la semana queres recibir tu notificación:', Character lf asString,
		'1.Lunes', Character lf asString,
		'2.Martes', Character lf asString,
		'3.Miercoles', Character lf asString,
		'4.Jueves', Character lf asString,
		'5.Viernes', Character lf asString,
		'6.Sabado', Character lf asString,
		'7.Domingo'.
]

{ #category : #'as yet unclassified' }
GAFBotMessageTemplateFactory >> summaryConfigSaveSuccessTextMessage [

	^ 'Perfecto, ya configuraste la frecuencia para recibir los mensajes sobre el estado de tu predio.'
]

{ #category : #'as yet unclassified' }
GAFBotMessageTemplateFactory >> summaryConfigSelectedFrecuency [

	^ 'Seleccionaste la opción *{{ frecuency }}*. Querés confirmar tu elección?
		Respondé “sí” para continuar o “no” para cambiar tu elección. '
]
