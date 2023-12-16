Class {
	#name : #TelegramConfigurationEditor,
	#superclass : #WAComponent,
	#instVars : [
		'persistentConfiguration'
	],
	#category : #'GapAFarm-ui-admin'
}

{ #category : #accessing }
TelegramConfigurationEditor >> persistentConfiguration [

	^ persistentConfiguration
]

{ #category : #accessing }
TelegramConfigurationEditor >> persistentConfiguration: anObject [

	persistentConfiguration := anObject
]

{ #category : #initialization }
TelegramConfigurationEditor >> renderBotStatusOn: html [

	| bot |
	bot := GAFBot singleton.
	html heading
		level: 4;
		with: 'Estado del Bot'.

	html paragraph with: [
		html text: 'Estado: '.
		bot running
			ifTrue: [
				html anchor
					callback: [ bot stopBot ];
					with: 'Detener' ]
			ifFalse: [
				html anchor
					callback: [ self startBot ];
					with: 'Activar' ] ].

	html form: [
		html label: 'Token: '.
		html space.
		html textInput
			on: #token of: bot;
			size: 60.
		html space.
		html submitButton: 'Guardar' ]
]

{ #category : #initialization }
TelegramConfigurationEditor >> renderBroadcastMessageFormOn: html [

	html form: [
		html label: 'Mensaje a enviar '.
		html break.
		html textArea
			callback: [ :value | GAFBot singleton broadcast: value ];
			rows: 4;
			columns: 80.
		html break.
		html submitButton: 'Enviar a todos' ]
]

{ #category : #initialization }
TelegramConfigurationEditor >> renderContentOn: html [

	html container
		style: 'padding-top: 20px';
		with: [
			self renderBotStatusOn: html.
			self renderBroadcastMessageFormOn: html ]
]

{ #category : #initialization }
TelegramConfigurationEditor >> rendererClass [
	^ SBSHtmlCanvas
]

{ #category : #initialization }
TelegramConfigurationEditor >> startBot [

	GAFBot singleton startBotPolling: 1
]
