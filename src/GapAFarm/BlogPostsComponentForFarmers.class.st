Class {
	#name : #BlogPostsComponentForFarmers,
	#superclass : #GAFAbstractTableWithFilterAndActionsComponent,
	#category : #'GapAFarm-ui-farmer'
}

{ #category : #rendering }
BlogPostsComponentForFarmers >> columnHeadings [
	^ {'Fecha' . 'Texto' . 'Tipo'}
]

{ #category : #rendering }
BlogPostsComponentForFarmers >> columnValuesFor: element [
	^ {element date ddmmyyyy.
	(self textFor: element).
	(self typeFor: element)}
]

{ #category : #hooks }
BlogPostsComponentForFarmers >> elementClass [
	"Returns the class of elements to edit and add"

	^ BlogPost
]

{ #category : #accessing }
BlogPostsComponentForFarmers >> elements [
	^ self session gapAFarm blogPostFor: self session farm
]

{ #category : #rendering }
BlogPostsComponentForFarmers >> initialize [
	super initialize.
	addEnabled := false.
	editEnabled := false.
	duplicateEnabled := false
]

{ #category : #rendering }
BlogPostsComponentForFarmers >> textFor: element [
	^ element text
		,
			(element moreInfoUrl
				ifEmpty: [ '' ]
				ifNotEmpty: [ :url | ' <a href="' , url , '" target="_blank">(ver más)</a>' ])
]

{ #category : #rendering }
BlogPostsComponentForFarmers >> typeFor: element [
	^ element isAlert
		ifTrue: [ '<strong style="color: red;">Alerta</strong>' ]
		ifFalse: [ element type ]
]
