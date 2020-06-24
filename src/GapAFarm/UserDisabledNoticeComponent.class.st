Class {
	#name : #UserDisabledNoticeComponent,
	#superclass : #GAFAbstractComponent,
	#category : #'GapAFarm-ui-login'
}

{ #category : #rendering }
UserDisabledNoticeComponent >> renderContentOn: html [
	html
		container: [ html break.
			html
				jumbotron: [ html heading
						level1;
						class: 'display-4';
						with: 'GAP-a-Farm'.
					"			html image
				style: 'padding-bottom: 20px;';
				style: 'max-width: 100%;';
				url: GAFLibrary / #farmomaticJpeg."
					html paragraph
						class: 'lead';
						with: 'Su usuario todavía no ha sido activado.'.
					html paragraph
						with:
							'Este servicio requiere que todos los nuevos usuarios sean activados por alguno de los administradores del sistema - comuniquese con ellos para que lo hagan.'.
					html anchor
						url: GAFLandingComponent url;
						with: [ html formButton
								bePrimary;
								with: 'Ok' ] ] ]
]
