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
2. La cantidad cosechada (quantity).
3. El lugar de la cosecha (plot) debe ser uno de los siguientes: {{plots}}
4. La hora.

Si no es posible reconocer alguno de los datos, no incluyas la propiedad en el JSON de salida. 

Aquí tienes un ejemplo de el mensaje del agricultor:

"Acabo de cosechar 150 de {{example-crop}} del invernadero {{example-plot}}."

Para la hora, en caso de que se haya indicado se debe usar el formato hh:mm.

Aquí tienes dos ejemplos de mensaje con respecto a la fecha:
"Acabo de cosechar 150 kilos de {{example-crop}} del invernadero {{example-plot}}." Acabo debe ser el día de hoy por lo que se esperaría que la fecha sea la del día de hoy.
"Ayer a las 9 de la mañana coseché 150 kilos de {{example crop}} de {{example-plot}}".

Respuesta esperada en formato JSON esperado:

{
  "crop": "{{example-crop}}",
  "quantity": "150"},
  "plot": "{{example-plot}}",
  "hour": "hh:mm"
}
'
]

{ #category : #templates }
GAFMustacheLibrary >> harvestMessageExtractionPrompt_exampleContext [
^'{"crops" : ["Tomate perita"]}'
]

{ #category : #'as yet unclassified' }
GAFMustacheLibrary >> harvestUpdateMessageExtractionPrompt [

^ 'A continuación te proporcionaré un mensajes de ejemplo para que puedas extraer datos de él. Los datos que deberías poder extraer son: 
1. plot: lote, 
2. crop: cultivo, 
3. hour: hora 
4. quantity: cantidad.

Ejemplos:
"Cambio lote por {{example-plot}}",
"Cambio cultivo por {{example-crop}}", 
"Cambio hora por 6:30",
"Cambio cantidad por {{example-quantity}} KG"

Para la hora, en caso de que se haya indicado se debe usar el formato hh:mm. 
La hora debe encontrarse en formato 24 hs, por lo tanto si el usuario indica "cambio hora por 6:30 de la tarde" el valor esperado para el dato "hour" debería ser 18:30.

Solo debería indicarse uno de los datos. Si no es posible reconocer alguno de los datos indicados, devolve el siguiente json:

{ 
	"field": "empty"
} 

Respuestas correctas esperadas (sólo una) en formato JSON esperado:

{
  "field": "crop",
  "crop": "{{example-crop}}"
}
{
  "field": "quantity", 
  "quantity": {
    "value": "150",
    "unit": "KG"
}
{
  "field": "plot", 
  "plot": "{{example-plot}}"
}
{ 
  "field": "hour",
  "hour": "hh:mm"
}

'
]
