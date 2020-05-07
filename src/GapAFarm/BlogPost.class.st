Class {
	#name : #BlogPost,
	#superclass : #Object,
	#instVars : [
		'type',
		'author',
		'text',
		'moreInfoUrl',
		'dateAndTime',
		'visibleThrough',
		'crops',
		'adversityTypes',
		'likes'
	],
	#category : #'GapAFarm-model'
}

{ #category : #voyage }
BlogPost class >> isVoyageRoot [
	^ true
]

{ #category : #constants }
BlogPost class >> types [
	^ {'Noticia' . 'Alerta' . 'Evento'}
]

{ #category : #accessing }
BlogPost >> adversityTypes [
	^ adversityTypes
]

{ #category : #accessing }
BlogPost >> adversityTypes: anObject [
	adversityTypes := anObject
]

{ #category : #accessing }
BlogPost >> author [
	^ author
]

{ #category : #accessing }
BlogPost >> author: anObject [
	author := anObject
]

{ #category : #accessing }
BlogPost >> crops [
	^ crops
]

{ #category : #accessing }
BlogPost >> crops: anObject [
	crops := anObject
]

{ #category : #accessing }
BlogPost >> date [
	^ dateAndTime ifNotNil: [ :it | it asDate ]
]

{ #category : #accessing }
BlogPost >> date: aDate [
	dateAndTime := aDate
		ifNil: [ nil ]
		ifNotNil: [ :it | aDate asDateAndTime ]
]

{ #category : #'instance-creation' }
BlogPost >> initialize [
	crops := OrderedCollection new.
	adversityTypes := OrderedCollection new.
	likes := 0.
]

{ #category : #testing }
BlogPost >> isAlert [
	^ type = 'Alerta'
]

{ #category : #reactions }
BlogPost >> like [
	likes := likes + 1
]

{ #category : #accessing }
BlogPost >> likes [
	^ likes
]

{ #category : #accessing }
BlogPost >> moreInfoUrl [
	^ moreInfoUrl
]

{ #category : #accessing }
BlogPost >> moreInfoUrl: anObject [
	moreInfoUrl := anObject
]

{ #category : #accessing }
BlogPost >> text [
	^ text
]

{ #category : #accessing }
BlogPost >> text: anObject [
	text := anObject
]

{ #category : #accessing }
BlogPost >> type [
	^ type
]

{ #category : #accessing }
BlogPost >> type: anObject [
	type := anObject
]

{ #category : #accessing }
BlogPost >> visibleThrough [
	^ visibleThrough
]

{ #category : #accessing }
BlogPost >> visibleThrough: anObject [
	visibleThrough := anObject
]
