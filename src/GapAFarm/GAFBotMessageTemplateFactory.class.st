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
	nextPutAll: '/novedades -> Para ver las novedades que aplican a tu granja.'.
	^stream contents.
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

	^'Comencemos configurando con qué frecuencia querés recibir mensajes sobre el estado de tu predio. Seleccioná una de las opciones:', Character lf asString,
	'Diariamente -> una vez por día', Character lf asString,
	'Semanalmente -> una vez a la semana'.
]

{ #category : #'as yet unclassified' }
GAFBotMessageTemplateFactory >> greetingTextMessage [

	^'Hola {{username}}. Soy AgroBot, tu nuevo ayudante!'
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
GAFBotMessageTemplateFactory >> summaryConfigAskHour [

	^ 'Bien. Ahora ingresa el horario en el que querés recibir tu resumen con formato 24hs.
Por ejemplo: 06:00 para la mañana o 18:00 para la tarde.'
]

{ #category : #'as yet unclassified' }
GAFBotMessageTemplateFactory >> summaryConfigAskHourTextMessage [

	^ 'Bien. Ahora ingresa el horario en el que querés recibir tu resumen con formato 24hs.
Por ejemplo: 06:00 para la mañana o 18:00 para la tarde.'
]

{ #category : #'as yet unclassified' }
GAFBotMessageTemplateFactory >> summaryConfigSelectedFrecuency [

	^ 'Seleccionaste la opción *{{ frecuency }}*. Querés confirmar tu elección?
		Respondé “sí” para continuar o “no” para cambiar tu elección. '
]
