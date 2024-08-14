Class {
	#name : #GAFMustacheLibrary,
	#superclass : #MustacheLibrary,
	#instVars : [
		'hour'
	],
	#category : #'GapAFarm-telegram'
}

{ #category : #templates }
GAFMustacheLibrary >> harvestMessageExtractionPrompt [
^'A continuación, te proporcionaré un mensaje de texto enviado por un agricultor que acaba de efectuar una cosecha. Necesito que extraigas la información específica del mensaje y la presentes en formato JSON válido (solo incluye JSON válido en tu respuesta). 

Los datos a extraer son:

1. El producto cosechado (crop) debe ser uno de los siguientes: {{crops}}.
2. La cantidad cosechada (quantity) debe estar expresada en una de las siguientes unidades: {{units}}.
3. El lugar de la cosecha (plot) debe ser uno de los siguientes: {{plots}}

Si no es posible reconocer alguno de los datos, no incluyas la propiedad en el JSON de salida. 

Aquí tienes un ejemplo de el mensaje del agricultor:

"Acabo de cosechar 150 {{example-unit}} de {{example-crop}} del invernadero {{example-plot}}."

Respuesta esperada en formato JSON esperado:

{
  "crop": "{{example-crop}}",
  "quantity": {
    "value": "150",
    "unit": "{{example-unit}}"
  },
  "plot": "{{example-plot}}"
}

'
]

{ #category : #templates }
GAFMustacheLibrary >> harvestMessageExtractionPrompt_exampleContext [
^'{"crops" : ["Tomate perita"]}'
]
