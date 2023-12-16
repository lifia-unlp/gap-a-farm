"
Each message return a template to be used as explained here: https://book.huihoo.com/smalltalk/pharo/enterprise-pharo/book-result/Mustache/Mustache.html
"
Class {
	#name : #GAFBotMessageTemplateFactory,
	#superclass : #Object,
	#category : #'GapAFarm-telegram'
}

{ #category : #problems }
GAFBotMessageTemplateFactory >> availableCommands [

	^ '/novedades -> Para ver las novedades que aplican a su granja.
	
/alertas -> Para ver las alertas disponibles para su granja.

/carencia -> Para ver el listado de lotes actualmente en carencia. 

...'
]

{ #category : #problems }
GAFBotMessageTemplateFactory >> farmNotSetNotification [

	^'Lo siento, _{{username}}_. No tengo una granja asociada a su usuario de telegram. Solicite al administrador de GAP-a-Farm que le vincule a una granja (para ello indíquele su identificador único de Telegram: *{{id}}*)'
]
