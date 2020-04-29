Class {
	#name : #GAFEmailErrorHandler,
	#superclass : #WAEmailErrorHandler,
	#category : #'GapAFarm-errors-exeptions'
}

{ #category : #private }
GAFEmailErrorHandler >> from [
	"ansers the WAEmailAddress instance used as a sender address"

	^ WAEmailAddress address: 'casco@lifia.info.unlp.edu.ar'
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
	html alert
		beDanger;
		with: [ html strong: 'Oh snap!'.
			html text: ' I encounter an error. I already tried to notify the admins. Be sure to export your reviews, just in case.' ]
]

{ #category : #private }
GAFEmailErrorHandler >> rendererClass [
	^ WAHtmlCanvas
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
