Class {
	#name : #GAFEmailErrorHandler,
	#superclass : #WAEmailErrorHandler,
	#category : #'GapAFarm-errors-exeptions'
}

{ #category : #private }
GAFEmailErrorHandler >> bodyFor: anError [
	^ WAStringEmailBody
		string:
			(String
				streamContents: [ :stream | 
					stream
						nextPutAll: self requestContext request url printString;
						cr;
						cr.
					anError signalerContext errorReportOn: stream ])
		lineLength: 72
]

{ #category : #private }
GAFEmailErrorHandler >> from [
	"ansers the WAEmailAddress instance used as a sender address"

	^ WAEmailAddress address: 'noreply@noreply.com'
]

{ #category : #actions }
GAFEmailErrorHandler >> handleDefault: anException [
	self requestContext respond: [ :response |
		response
			internalError;
			contentType: WAMimeType textHtml;
			nextPutAll: (self rendererClass builder
				fullDocument: true;
				rootBlock: [ :root | self updateHtmlRoot: root forException: anException ];
				render: [ :html | self renderContentForException: anException on: html ]) ]
]

{ #category : #private }
GAFEmailErrorHandler >> renderContentForException: anException on: html [
	html heading
		level: 1;
		with: 'Ahg!'.
	html
		paragraph: ' Estoy experimentando algunas dificultades.';
		paragraph:
			'Ya doy aviso a los administradores para que lo revuelvan a la brevedad.'
]

{ #category : #private }
GAFEmailErrorHandler >> rendererClass [
	^ WAHtmlCanvas
]

{ #category : #private }
GAFEmailErrorHandler >> subjectFor: anError [
	^ 'GAP-a-Farm error: ' , anError signalerContext printString
]

{ #category : #private }
GAFEmailErrorHandler >> titleForException: anException [
	^ anException description
]

{ #category : #private }
GAFEmailErrorHandler >> to [
	^ WAEmailAddress address: 'casco@lifia.info.unlp.edu.ar'
]

{ #category : #private }
GAFEmailErrorHandler >> updateHtmlRoot: anHtmlRoot forException: anException [
	anHtmlRoot title: (self titleForException: anException)
]
