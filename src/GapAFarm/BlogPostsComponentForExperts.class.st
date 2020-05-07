Class {
	#name : #BlogPostsComponentForExperts,
	#superclass : #GAFAbstractTableWithFilterAndActionsComponent,
	#category : #'GapAFarm-ui-expert'
}

{ #category : #rendering }
BlogPostsComponentForExperts >> columnHeadings [
	^ {'Fecha' . 'Visibilidad' . 'Texto' . 'Me gusta'}
]

{ #category : #rendering }
BlogPostsComponentForExperts >> columnValuesFor: element [
	^ {element date asDate ddmmyyyy.
	(self visibilityStringFor: element).
	element text.
	element likes printString}
]

{ #category : #hooks }
BlogPostsComponentForExperts >> elementClass [
	"Returns the class of elements to edit and add"

	^ BlogPost
]

{ #category : #hooks }
BlogPostsComponentForExperts >> elementEditorClass [
	"Returns the class of editor used to edit elements"

	^ BlogPostEditorComponent
]

{ #category : #accessing }
BlogPostsComponentForExperts >> elements [
	^ self session gapAFarm blogPosts
]

{ #category : #initialization }
BlogPostsComponentForExperts >> initialize [
	super initialize.
	duplicateEnabled := false.
	removeEnabled := true.
	viewEnabled := false.
	editEnabled := true.
]

{ #category : #callbacks }
BlogPostsComponentForExperts >> removeElement: element [
	^ element remove
]

{ #category : #rendering }
BlogPostsComponentForExperts >> visibilityStringFor: element [
	^ String
		streamContents: [ :stream | 
			element visibleThrough
				ifNotNil: [ :it | 
					stream
						nextPutAll: 'Hasta el: ';
						nextPutAll: it asDate ddmmyyyy;
						nextPutAll: '. ' ].
			element crops , element adversityTypes
				ifNotEmpty: [ :they | 
					stream
						nextPutAll: 'Para: ';
						nextPutAll: they asCommaString;
						nextPutAll: '. ' ] ]
]
