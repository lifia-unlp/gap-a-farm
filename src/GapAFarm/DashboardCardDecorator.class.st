Class {
	#name : #DashboardCardDecorator,
	#superclass : #GAFAbstractComponent,
	#instVars : [
		'title',
		'subtitle',
		'component',
		'imageUrl',
		'size'
	],
	#category : #'GapAFarm-ui-common'
}

{ #category : #accessing }
DashboardCardDecorator >> component: anObject [
	component := anObject
]

{ #category : #testing }
DashboardCardDecorator >> hasElementsToShow [
	^ component hasElementsToShow
]

{ #category : #accessing }
DashboardCardDecorator >> imageUrl: aWAUrl [
	imageUrl := aWAUrl
]

{ #category : #rendering }
DashboardCardDecorator >> renderCardOn: html [
	html card
		class: 'shadow';
		style: 'margin-bottom: 20px;';
		with: [ imageUrl
				ifNotNil: [ html div
						class: 'embed-responsive embed-responsive-21by9';
						style: 'object-fit: cover;';
						with: [ html image
								class: 'card-img-top embed-responsive-item';
								altText: title;
								url: imageUrl ] ].
			html
				cardBody: [ html cardTitle level5 with: title.
					subtitle
						ifNotNil: [ html cardSubtitle
								level6;
								style: 'margin-bottom: 10px;';
								mutedText;
								with: subtitle ].
					html render: component ] ]
]

{ #category : #rendering }
DashboardCardDecorator >> renderContentOn: html [
	self renderCardOn: html
]

{ #category : #accessing }
DashboardCardDecorator >> size: anObject [
	size := anObject
]

{ #category : #accessing }
DashboardCardDecorator >> sizeOfColumn [
	^ size
]

{ #category : #accessing }
DashboardCardDecorator >> subtitle: anObject [
	subtitle := anObject
]

{ #category : #accessing }
DashboardCardDecorator >> title: anObject [
	title := anObject
]
